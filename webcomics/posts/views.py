from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView

from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone

from profiles.models import User 
from comments.forms import CommentForm
from comments.utils import get_comment_list
from comments.models import Comment

from series.models import Series
from categories.models import Category

from .forms import PostForm
from .models import Post

from .utils import rank_hot


class BrowseMixin(object):
    paginate_by = 16
    def get_queryset(self):
        qs = super(BrowseMixin, self).get_queryset()

        # Filter published
        # qs = qs.filter(published=True)

        # Filter by category
        category = self.request.GET.get('category')
        if category:
            category = Category.objects.get(slug=category)
            qs = qs.filter(categories=category)

        # Sort
        sorting = self.request.GET.get('sorting')
        if sorting == 'top':
            qs = qs.order_by('-score')
        elif sorting == 'new':
            qs = qs.order_by('-pub_date')
        else:
            qs = rank_hot(qs)

        return qs

    def get_context_data(self, **kwargs):
        context = super(BrowseMixin, self).get_context_data(**kwargs)
        if self.request.GET.get('sorting'):
            context['sorting'] = self.request.GET.get('sorting')
        else:
            context['sorting'] = "hot"
        context['category'] = self.request.GET.get('category')
        context['categories'] = Category.objects.all()
        return context
    


class BrowseView(BrowseMixin, ListView):
    model = Post
    template_name = "posts/browse.html"

    

class SubscriptionsView(BrowseMixin, ListView):
    model = Post
    template_name = "posts/browse.html"

    def get_queryset(self):
        qs = super(SubscriptionsView, self).get_queryset()        
        # Filter Subscriptions
        subscribed = self.request.user.subscribed.all()
        # qs = qs.filter(author__in=subscribed)
        qs = [post for post in qs if post.author in subscribed]

        return qs
    
    
    
class ProfileView(BrowseMixin, ListView):
    model = Post
    template_name = "posts/profile.html"

    def get_queryset(self):
        qs = super(ProfileView, self).get_queryset()
        # Filter by userprofile
        userprofile = User.objects.get(username=self.kwargs['username'])
        # qs = qs.filter(author=userprofile)
        qs = [post for post in qs if post.author == userprofile]

        return qs

    def get_context_data(self, **kwargs):
        context = super(ProfileView, self).get_context_data(**kwargs)

        username = self.kwargs['username']
        userprofile = User.objects.get(username=username)
        context['userprofile'] = userprofile

        view_count = 0
        for post in userprofile.posts.all():
            view_count += post.views
        context['view_count'] = view_count
            
        return context
    

    
class PostDetailView(DetailView):
    model = Post
    template_name = "posts/post.html"
    
    def get_context_data(self, **kwargs):
        context = super(PostDetailView, self).get_context_data(**kwargs)
        context['now'] = timezone.now()

        post = self.get_object()
        if not self.request.user.is_staff and self.request.user != post.author:
            post.views +=1
            post.save()


        qs = super(PostDetailView, self).get_queryset()
        other_posts = qs.filter(series=post.series)
        context['first'] = other_posts.order_by('pub_date')[0]
        context['prev'] = post.prev_by_author()
        context['next'] = post.next_by_author()        
        context['last'] = other_posts.order_by('-pub_date')[0]


        more_by = Post.objects.filter(author=post.author, published=True).order_by('?')[:4]
        context['more_by'] = more_by
        # next_post = post.get_next_by_pub_date(post, author=post.author)
        # next_post = next_or_prev_in_order(self, True, other_posts)        


        ##### COMMENTS ####
        context['form'] = CommentForm()

        top_lvl_comments = Comment.objects.filter(post = post, parent = None)

        rankby = "new"
        # Rank comments
        # if rankby == "hot" or True:
        #     ranked_comments = rank_hot(top_lvl_comments, top=32)
        # elif rankby == "top":
        #     ranked_comments = rank_top(top_lvl_comments, timespan = "all-time")
        # elif rankby == "new":
        #     ranked_comments = top_lvl_comments.order_by('-pub_date')
        # else:
        #     ranked_comments = []

        ranked_comments = top_lvl_comments.order_by('-pub_date')

        # Nested comments
        comments = list(get_comment_list(ranked_comments, rankby=rankby))

        # if request.user.is_authenticated():
        #     comments_upvoted = request.user.comments_upvoted.all()
        #     comments_downvoted = request.user.comments_downvoted.all()                
        # else:
        #     comments_upvoted = []
        #     comments_downvoted = []  

        context['comments'] = comments
        # 'comments_upvoted': comments_upvoted,
        # 'comments_downvoted': comments_downvoted,
        

        return context    



class PostCreate(CreateView):
    model = Post
    form_class = PostForm
    template_name = 'posts/edit.html'
    
    success_url = "/"
    template_name = 'posts/edit.html'

    def form_valid(self, form):
       user = self.request.user
       form.instance.author = user
       success_url = "/post/"+form.instance.slug+"/edit"
       return super(PostCreate, self).form_valid(form)
    


    def get_success_url(self):
        success_url = "/post/"+self.object.slug+"/edit"
        return success_url
        # return self.request.path    

    def get_context_data(self, **kwargs):
        context = super(PostCreate, self).get_context_data(**kwargs)
        context['creating'] = True
        return context    
    # return redirect("/post/"+post.slug+"/edit")


class PostEdit(UpdateView):
    model = Post
    # fields = ["title","image","thumbnail","description","categories"]
    form_class = PostForm
    # success_url = "/"
    template_name = 'posts/edit.html'

    def get_success_url(self):
        return self.request.path

    def get_form_kwargs(self):
        kwargs = super(PostEdit, self).get_form_kwargs()
        kwargs.update({'user': self.request.user})
        return kwargs    
        


def post_publish(request, slug):
    post = Post.objects.get(slug=slug)

    # throw him out if he's not an author    
    if request.user != post.author:
        return HttpResponseRedirect('/')        

    post.published = True
    post.save()

    return HttpResponseRedirect('/post/'+post.slug+'/edit')


def post_unpublish(request, slug):
    post = Post.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != post.author:
        return HttpResponseRedirect('/')        

    post.published = False
    post.save()
    return HttpResponseRedirect('/post/'+post.slug+'/edit')

def post_delete(request, slug):
    post = Post.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != post.author:
        return HttpResponseRedirect('/')        

    post.delete()
    return HttpResponseRedirect('/')




# Voting
def upvote(request):
    post = get_object_or_404(Post, id=request.POST.get('post-id'))
    post.score += 1
    post.save()
    post.author.karma += 1
    post.author.save()
    user = request.user
    user.upvoted.add(post)
    user.save()
    return HttpResponse()

def unupvote(request):
    post = get_object_or_404(Post, id=request.POST.get('post-id'))
    post.score -= 1
    post.save()
    post.author.karma = 1
    post.author.save()
    user = request.user
    user.upvoted.remove(post)
    user.save()
    return HttpResponse()
        


def testview(request):
    return render(request, 'posts/profile.html', {
    })
        

