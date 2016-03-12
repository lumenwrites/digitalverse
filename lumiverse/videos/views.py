from sorl.thumbnail import get_thumbnail
from django.core.files.base import ContentFile

from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView

from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone

# rss
from django.contrib.syndication.views import Feed
from django.utils.feedgenerator import Atom1Feed
from markdown import Markdown

from profiles.models import User 
from comments.forms import CommentForm
from comments.utils import get_comment_list
from comments.models import Comment

from series.models import Series
from categories.models import Category
from hubs.models import Hub

from .forms import VideoForm
from .models import Video

from .utils import rank_hot


class BrowseMixin(object):
    paginate_by = 16
    def get_queryset(self):
        qs = super(BrowseMixin, self).get_queryset()

        # Filter published
        # qs = qs.filter(published=True)

        # Filter by hub
        hub = self.request.GET.get('hub')
        if hub:
            hub = Hub.objects.get(slug=hub)
            qs = qs.filter(hubs=hub)

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
        context['hub'] = self.request.GET.get('hub')
        context['hubs'] = Hub.objects.all()
        return context
    


class BrowseView(BrowseMixin, ListView):
    model = Video
    template_name = "videos/browse.html"
    
    

class SubscriptionsView(BrowseMixin, ListView):
    model = Video
    template_name = "videos/browse.html"

    def get_queryset(self):
        qs = super(SubscriptionsView, self).get_queryset()        
        # Filter Subscriptions
        subscribed = self.request.user.subscribed.all()
        # qs = qs.filter(author__in=subscribed)
        qs = [video for video in qs if video.author in subscribed]

        return qs
    
    
    
class ProfileView(BrowseMixin, ListView):
    model = Video
    template_name = "videos/profile.html"
    paginate_by=15
    
    def get_queryset(self):
        qs = super(ProfileView, self).get_queryset()
        # Filter by userprofile
        userprofile = User.objects.get(username=self.kwargs['username'])
        # qs = qs.filter(author=userprofile)
        qs = [video for video in qs if video.author == userprofile]

        return qs

    def get_context_data(self, **kwargs):
        context = super(ProfileView, self).get_context_data(**kwargs)

        username = self.kwargs['username']
        userprofile = User.objects.get(username=username)
        context['userprofile'] = userprofile

        view_count = 0
        for video in userprofile.videos.all():
            view_count += video.views
        context['view_count'] = view_count
            
        return context
    

    
class VideoDetailView(DetailView):
    model = Video
    template_name = "videos/video.html"
    
    def get_context_data(self, **kwargs):
        context = super(VideoDetailView, self).get_context_data(**kwargs)
        context['now'] = timezone.now()

        video = self.get_object()
        if not self.request.user.is_staff and self.request.user != video.author:
            video.views +=1
            video.save()


        qs = super(VideoDetailView, self).get_queryset()
        other_videos = qs.filter(series=video.series)
        context['first'] = other_videos.order_by('pub_date')[0]
        context['prev'] = video.prev_by_author()
        context['next'] = video.next_by_author()        
        context['last'] = other_videos.order_by('-pub_date')[0]


        more_by = Video.objects.filter(author=video.author, published=True).order_by('?')[:4]
        context['more_by'] = more_by
        # next_video = video.get_next_by_pub_date(video, author=video.author)
        # next_video = next_or_prev_in_order(self, True, other_videos)        


        ##### COMMENTS ####
        context['form'] = CommentForm()

        top_lvl_comments =Comment.objects.filter(video = video, parent = None)

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



def video_create(request):
    if request.method == 'POST':
        form = VideoForm(request.POST, request.FILES, user=request.user)
        if form.is_valid():
            video = form.save(commit=False)
            video.author = request.user
            video.video = form.cleaned_data['video']
            video.video_url = form.cleaned_data['video_url']
            video.save()
            video.hubs = form.cleaned_data['hubs']
            video.save()
            
            # Upload Images
            # for image in form.cleaned_data['images']:
            #     Image.objects.create(image=image, video=video)       
            # Create Thumbnail
            # image = video.images.all()[0]
            # resized = get_thumbnail(image.image, "400x400", crop='center', quality=99)
            # video.thumbnail.save(resized.name, ContentFile(resized.read()), True)            

            return HttpResponseRedirect('/video/'+video.slug+'/edit')
    else:
        form = VideoForm(user=request.user)
    return render(request, 'videos/edit.html', {
        'form':form,
        'creating': True
    })

def video_edit(request,slug):
    video = Video.objects.get(slug=slug)

    if request.user != video.author and not request.user.is_staff:
        return HttpResponseRedirect('/')        
    
    if request.method == 'POST':
        form = VideoForm(request.POST, request.FILES, instance=video,user=request.user)
        if form.is_valid():
            video = form.save(commit=False)
            video.author = request.user
            video.video = form.cleaned_data['video']
            video.video_url = form.cleaned_data['video_url']
            video.hubs = form.cleaned_data['hubs']
            video.save()


            return HttpResponseRedirect('/video/'+video.slug+'/edit')
    else:
        form = VideoForm(instance=video,user=request.user)
    return render(request, 'videos/edit.html', {
        'form':form,
        'video':video
    })


# class VideoCreate(CreateView):
#     model = Video
#     form_class = VideoForm
#     template_name = 'videos/edit.html'
    
#     success_url = "/"
#     template_name = 'videos/edit.html'

#     def form_valid(self, form):
#        user = self.request.user
#        form.instance.author = user
#        images = form.instance.images

#        # video = form.save()
#        return super(VideoCreate, self).form_valid(form)
    


#     def get_success_url(self):
#         success_url = "/video/"+self.object.slug+"/edit"
        
#         video = Video.objects.get(slug=self.object.slug)
#         image = Image.objects.create(image=form.cleaned_data['image'])
#         image.video = video # self.object
#         image.save()
        
#         return success_url
#         # return self.request.path    

#     def get_form_kwargs(self):
#         kwargs = super(VideoCreate, self).get_form_kwargs()
#         kwargs.update({'user': self.request.user})
#         return kwargs    

#     def get_context_data(self, **kwargs):
#         context = super(VideoCreate, self).get_context_data(**kwargs)
#         context['creating'] = True
#         return context    
#    # return redirect("/video/"+video.slug+"/edit")


# class VideoEdit(UpdateView):
#     model = Video
#     # fields = ["title","image","thumbnail","description","hubs"]
#     form_class = VideoForm
#     # success_url = "/"
#     template_name = 'videos/edit.html'

#     def get_success_url(self):
#         return self.request.path

#     def get_form_kwargs(self):
#         kwargs = super(VideoEdit, self).get_form_kwargs()
#         kwargs.update({'user': self.request.user})
#         return kwargs    
        


def video_publish(request, slug):
    video = Video.objects.get(slug=slug)

    # throw him out if he's not an author    
    if request.user != video.author:
        return HttpResponseRedirect('/')        

    video.published = True
    video.save()

    return HttpResponseRedirect('/video/'+video.slug+'/edit')


def video_unpublish(request, slug):
    video = Video.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != video.author:
        return HttpResponseRedirect('/')        

    video.published = False
    video.save()
    return HttpResponseRedirect('/video/'+video.slug+'/edit')

def video_delete(request, slug):
    video = Video.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != video.author:
        return HttpResponseRedirect('/')        

    video.delete()
    return HttpResponseRedirect('/')




# Voting
def upvote(request):
    video = get_object_or_404(Video, id=request.POST.get('post-id'))
    video.score += 1
    video.save()
    video.author.karma += 1
    video.author.save()
    user = request.user
    user.upvoted.add(video)
    user.save()
    return HttpResponse()

def unupvote(request):
    video = get_object_or_404(Video, id=request.POST.get('post-id'))
    video.score -= 1
    video.save()
    video.author.karma = 1
    video.author.save()
    user = request.user
    user.upvoted.remove(video)
    user.save()
    return HttpResponse()
        


# rss
class UserFeed(Feed):
    title = "Django Zone latests videos"
    link = "/"
    feed_type = Atom1Feed

    def get_object(self, request, username):
        return get_object_or_404(User, username=username)

    def title(self, obj):
        return "lumiverse.io: %s videos" % obj.username

    def link(self, obj):
        return "http://lumiverse.io/user/" + obj.username
    
    def items(self, obj):
        return Video.objects.filter(published=True, author=obj).order_by("-pub_date")

    def item_title(self, item):
        return item.title

    def item_pubdate(self, item):
        return item.pub_date
    
    def item_enclosure_url(self, item):
        if item.video_url:
            return "https://www.youtube.com/watch?v="+item.video_url
        else:
            return "http://lumiverse.io/media/"+str(item.video)

    def item_description(self, item):
        md = Markdown()
        return md.convert(item.description)



class SeriesFeed(Feed):
    title = "Django Zone latests videos"
    link = "/"
    feed_type = Atom1Feed

    def get_object(self, request, slug):
        return get_object_or_404(Series, slug=slug)

    def title(self, obj):
        return "webcomics.io: %s series" % obj.title

    def link(self, obj):
        return "http://webcomics.io/series/" + obj.slug

    def items(self, obj):
        return Video.objects.filter(published=True, series=obj).order_by("-pub_date")

    def item_title(self, item):
        return item.title

    def item_pubdate(self, item):
        return item.pub_date

    
    def item_enclosure_url(self, item):
        if item.video_url:
            return "https://www.youtube.com/watch?v="+item.video_url
        else:
            return "http://lumiverse.io/media/"+str(item.video)
    
    def item_description(self, item):
        md = Markdown()
        return md.convert(item.description)




def item(request):
    return render(request, 'store/item.html', {})

def testview(request):
    return render(request, 'videos/profile.html', {
    })
        




