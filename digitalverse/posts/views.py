# standard library imports
import datetime
import re, random
from string import punctuation
from math import floor # to round views


# core django components
# CBVs
from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView

from django.db.models import Q
from django.shortcuts import render, get_object_or_404, redirect
from django.http import HttpResponseRedirect, HttpResponse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

# for 404
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.utils.timezone import utc

from django.conf import settings


# My own stuff
# utility functions
# from comments.utils import get_comment_list, get_comments, submit_comment
from .utils import rank_hot, rank_top
from .utils import count_words
from .shortcuts import get_or_none
from comments.utils import get_comment_list

# Forms
from .forms import PostForm
from comments.forms import CommentForm
# from hubs.forms import HubForm
# Models
from .models import Post
from profiles.models import User
# from hubs.models import Hub
from comments.models import Comment
# from notifications.models import Message





class FilterMixin(object):
    paginate_by = 15
    def get_queryset(self):
        qs = super(FilterMixin, self).get_queryset()

        # Filter by hubs
        # try:
        #     selectedhubs = self.request.GET['hubs'].split(",")
        # except:
        #     selectedhubs = []
        # filterhubs = []
        # if selectedhubs:
        #     for hubslug in selectedhubs:
        #         filterhubs.append(Hub.objects.get(slug=hubslug))
        # for hub in filterhubs:
        #     qs = qs.filter(hubs=hub)            

        # Filter by query
        # query = self.request.GET.get('query')
        # if query:
        #     qs = qs.filter(Q(title__icontains=query) |
        #                    Q(body__icontains=query) |
        #                    Q(author__username__icontains=query))                    

        # Sort
        # (Turns queryset into the list, can't just .filter() later
        sorting = self.request.GET.get('sorting')
        if sorting == 'top':
            qs = qs.order_by('-score')
        elif sorting == 'new':
            qs = qs.order_by('-pub_date')
        else:
            qs = rank_hot(qs)

        return qs

    def get_context_data(self, **kwargs):
        context = super(FilterMixin, self).get_context_data(**kwargs)
        urlstring = ""
        # Sorting
        if self.request.GET.get('sorting'):
            sorting = self.request.GET.get('sorting')
        else:
            sorting = "hot"
        context['sorting'] = sorting

        # # Filtered Hubs
        # try:
        #     selectedhubs = self.request.GET['hubs'].split(",")
        # except:
        #     selectedhubs = []
        # filterhubs = []
        # if selectedhubs:
        #     for hubslug in selectedhubs:
        #         filterhubs.append(Hub.objects.get(slug=hubslug))
        # context['filterhubs'] = filterhubs
        # # All Hubs
        # context['hubs'] = Hub.objects.all()
        # # Solo Hub
        # context['hub'] = self.request.GET.get('hub')


        # if filterhubs:
        #     hublist = ",".join([hub.slug for hub in filterhubs])
        #     urlstring += "&hubs=" + hublist

        # # Query
        # query = self.request.GET.get('query')
        # if query:
        #     context['query'] = query
        #     urlstring += "&query=" + query            

        context['urlstring'] = urlstring

        return context
    



class BrowseView(FilterMixin, ListView):
    model = Post
    context_object_name = 'posts'    
    template_name = "posts/browse.html"

    def get_queryset(self):
        qs = super(BrowseView, self).get_queryset()        
        qs = [p for p in qs if (p.published == True)]

        return qs


class BlogView(ListView):
    model = Post
    context_object_name = 'posts'    
    template_name = "posts/blog.html"

    def get_queryset(self):
        qs = super(BlogView, self).get_queryset()
        qs = qs.order_by('-pub_date')
        qs = [p for p in qs if (p.published == True and
                                p.author.username == "rayalez")]
        # and p.dvblog == True        
        
        # qs.sort(key=lambda x: x.pub_date, reverse=True)


        return qs
    


def PostView(request):
    return render(request, 'forum/post.html', {
    })



def post(request, slug):
    if request.path[-1] == '/':
        return redirect(request.path[:-1])

    post = get_object_or_404(Post, slug=slug)

    # Comments
    top_lvl_comments =Comment.objects.filter(post=post, parent = None)

    rankby = "hot"
    # Rank comments 
    if rankby == "hot":
        ranked_comments = rank_hot(top_lvl_comments)
    elif rankby == "top":
        ranked_comments = rank_top(top_lvl_comments, timespan = "all-time")
    elif rankby == "new":
        ranked_comments = top_lvl_comments.order_by('-pub_date')
    else:
        ranked_comments = []

    # Nested comments
    comments = list(get_comment_list(ranked_comments, rankby=rankby))

    # # Submit comments
    if request.method == 'POST':
        if chapter:
            submit_comment(request, chapter)
        else:
            submit_comment(request, post)            
    form = CommentForm()

    # Footer info
    if request.user.is_authenticated():
        upvoted = request.user.upvoted.all()
        # subscribed_to = request.user.subscribed_to.all()
        comments_upvoted = request.user.comments_upvoted.all()
    else:
        upvoted = []
        # subscribed_to = []
        comments_upvoted = []

    # hubs = post.hubs.all()        

    # Increment views counter. Do clever memcache laters.
    if not request.user.is_staff and request.user != post.author:
        post.views +=1
        post.save()
        
    return render(request, 'posts/post.html',{
        'post': post,
        'upvoted': upvoted,
        'comments': comments,
        'comments_upvoted': comments_upvoted,
        'form': form,
        # 'hubs':hubs,
        # 'subscribed_to':subscribed_to,
    })




def post_create(request):
    if request.method == 'POST':
        form = PostForm(request.POST)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            # post.score += 1 # self upvote
            post.save()
            # request.user.upvoted.add(post)
            
            # Add hubs
            # post.hubs.add(*form.cleaned_data['hubs'])
            # hubs = post.hubs.all()

            return HttpResponseRedirect('/post/'+post.slug) # +'/edit'
    else:
        form = PostForm()
        # form.fields["hubs"].queryset = Hub.objects.filter(hub_type="hub")

    return render(request, 'posts/create.html', {
        'form':form,
        # 'hubs':Hub.objects.all(),
        })


def post_edit(request, slug):
    post = Post.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != post.author and not request.user.is_staff:
        return HttpResponseRedirect('/')        

    if request.method == 'POST':
        form = PostForm(request.POST,instance=post)
        if form.is_valid():
            post = form.save(commit=False)
            if request.POST.get('wipupdate'):
                post.pub_date = datetime.datetime.now()

            post.save(slug=post.slug)                
            # post.hubs = []
            # post.hubs.add(*form.cleaned_data['hubs'])
            return HttpResponseRedirect('/post/'+post.slug) # +'/edit'
    else:
        form = PostForm(instance=post)
        # form.fields["hubs"].queryset = Hub.objects.filter(hub_type="hub")

    return render(request, 'posts/edit.html', {
        'post':post,
        'form':form,
    })


def post_delete(request, post):
    post = Post.objects.get(slug=post)

    # throw him out if he's not an author
    if request.user != post.author:
        return HttpResponseRedirect('/')        

    post.delete()
    return HttpResponseRedirect('/') # to post list



# Voting
def upvote(request):
    post = get_object_or_404(Post, id=request.POST.get('post-id'))
    post.score += 1
    post.save()
    post.author.karma += 1
    post.author.save()
    user = request.user
    user.posts_upvoted.add(post)
    user.save()

    # Notification
    # message = Message(from_user=request.user,
    #                   to_user=post.author,
    #                   story=post,
    #                   message_type="upvote")
    # message.save()
    # post.author.new_notifications = True
    # post.author.save()
    return HttpResponse()

def unupvote(request):
    post = get_object_or_404(Post, id=request.POST.get('post-id'))
    post.score -= 1
    post.save()
    post.author.karma -= 1
    post.author.save()
    user = request.user
    user.posts_upvoted.remove(post)
    user.save()
    return HttpResponse()





class UserprofileView(FilterMixin, ListView):
    model = Post
    context_object_name = 'posts'    
    template_name = "posts/blog.html"

    def get_queryset(self):
        qs = super(UserprofileView, self).get_queryset()

        qs.sort(key=lambda x: x.pub_date, reverse=True)

        # Filter by user
        userprofile = User.objects.get(username=self.kwargs['username'])        
        qs = [p for p in qs if (p.author==userprofile)]

        # Show only published to everyone else
        # if self.request.user != userprofile:
        #     qs = [p for p in qs if (p.published==True)]            
        
        return qs

    def get_context_data(self, **kwargs):
        context = super(UserprofileView, self).get_context_data(**kwargs)
        userprofile = User.objects.get(username=self.kwargs['username'])        
        context['userprofile'] = userprofile

        # Sorting
        if self.request.GET.get('sorting'):
            sorting = self.request.GET.get('sorting')
        else:
            sorting = "new"
        context['sorting'] = sorting
        

        view_count = 0
        for post in userprofile.posts.all():
            view_count += post.views
        if view_count > 1000:
            view_count = str(floor(view_count/1000)) + "K"
        context['view_count'] = view_count
                
        score = 0        
        for post in userprofile.posts.all():
            score += post.score
        if score > 1000:
            score = str(int(score/1000)) + "K"
        context['score'] = score
        
        return context    
    
