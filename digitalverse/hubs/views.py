from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView

from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone

from profiles.models import User 

from videos.models import Video

from .forms import HubForm
from .models import Hub

# from .utils import rank_hot

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

class HubsBrowse(BrowseMixin, ListView):
    model = Hub
    template_name = "hubs/browse.html"        


class HubView(BrowseMixin, ListView):
    model = Video
    template_name = "hubs/hub.html"
    paginate_by=16
    
    def get_queryset(self):
        qs = super(HubView, self).get_queryset()
        qs = sorted(qs, key=lambda x: x.pub_date, reverse=False)
        # qs.reverse()
        # Filter Videos
        hub = Hub.objects.get(slug=self.kwargs['slug'])
        qs = [video for video in qs if video.hubs == hub]

        return qs

    def get_context_data(self, **kwargs):
        context = super(HubView, self).get_context_data(**kwargs)

        hub = Hub.objects.get(slug=self.kwargs['slug'])        
        context['hub'] = hub

        view_count = 0
        for video in hub.videos.all():
            view_count += video.views
        context['view_count'] = view_count

        upvotes_count = 0
        for video in hub.videos.all():
            upvotes_count += video.score
        context['upvotes_count'] = upvotes_count
        
        return context
    
    

def subscribe(request, slug):
    hub = Hub.objects.get(slug=slug)
    if not request.user.is_anonymous():
        user = request.user
        user.subscribed_hub.add(hub)
        user.save()
        return HttpResponseRedirect(request.META.get('HTTP_REFERER')) 
    else:
        return HttpResponseRedirect('/login/')    

def unsubscribe(request, slug):
    hub = Hub.objects.get(slug=slug)    
    user = request.user
    user.subscribed_hub.remove(hub)
    user.save()
    return HttpResponseRedirect(request.META.get('HTTP_REFERER')) 
    


class HubCreate(CreateView):
    model = Hub
    form_class = HubForm
    template_name = 'hubs/edit.html'
    
    success_url = "/"

    def form_valid(self, form):
       user = self.request.user
       form.instance.author = user
       return super(HubCreate, self).form_valid(form)
    


    def get_success_url(self):
        success_url = "/hub/"+self.object.slug+"/edit"
        return success_url


    def get_context_data(self, **kwargs):
        context = super(HubCreate, self).get_context_data(**kwargs)
        context['creating'] = True
        return context    



class HubEdit(UpdateView):
    model = Hub
    form_class = HubForm
    # success_url = "/"
    template_name = 'hubs/edit.html'

    def get_success_url(self):
        return self.request.path

        


# def video_publish(request, slug):
#     video = Video.objects.get(slug=slug)

#     # throw him out if he's not an author    
#     if request.user != video.author:
#         return HttpResponseRedirect('/')        

#     video.published = True
#     video.save()

#     return HttpResponseRedirect('/video/'+video.slug+'/edit')


# def video_unpublish(request, slug):
#     video = Video.objects.get(slug=slug)

#     # throw him out if he's not an author
#     if request.user != video.author:
#         return HttpResponseRedirect('/')        

#     video.published = False
#     video.save()
#     return HttpResponseRedirect('/video/'+video.slug+'/edit')

def hub_delete(request, slug):
    hub = Hub.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != hubs.author:
        return HttpResponseRedirect('/')        

    hub.delete()
    return HttpResponseRedirect('/')




