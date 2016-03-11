from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView

from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone

from profiles.models import User 

from videos.models import Video
from videos.views import BrowseMixin

from .forms import SeriesForm
from .models import Series

# from .utils import rank_hot




class SeriesView(BrowseMixin, ListView):
    model = Video
    template_name = "series/series.html"
    paginate_by=16
    
    def get_queryset(self):
        qs = super(SeriesView, self).get_queryset()
        qs = sorted(qs, key=lambda x: x.pub_date, reverse=False)
        # qs.reverse()
        # Filter Videos
        series = Series.objects.get(slug=self.kwargs['slug'])
        qs = [video for video in qs if video.series == series]

        return qs

    def get_context_data(self, **kwargs):
        context = super(SeriesView, self).get_context_data(**kwargs)

        series = Series.objects.get(slug=self.kwargs['slug'])        
        context['series'] = series

        view_count = 0
        for video in series.videos.all():
            view_count += video.views
        context['view_count'] = view_count

        upvotes_count = 0
        for video in series.videos.all():
            upvotes_count += video.score
        context['upvotes_count'] = upvotes_count
        
        return context
    
    

def subscribe(request, slug):
    series = Series.objects.get(slug=slug)
    if not request.user.is_anonymous():
        user = request.user
        user.subscribed_series.add(series)
        user.save()
        return HttpResponseRedirect(request.META.get('HTTP_REFERER')) 
    else:
        return HttpResponseRedirect('/login/')    

def unsubscribe(request, slug):
    series = Series.objects.get(slug=slug)    
    user = request.user
    user.subscribed_series.remove(series)
    user.save()
    return HttpResponseRedirect(request.META.get('HTTP_REFERER')) 
    


class SeriesCreate(CreateView):
    model = Series
    form_class = SeriesForm
    template_name = 'series/edit.html'
    
    success_url = "/"

    def form_valid(self, form):
       user = self.request.user
       form.instance.author = user
       return super(SeriesCreate, self).form_valid(form)
    


    def get_success_url(self):
        success_url = "/series/"+self.object.slug+"/edit"
        return success_url


    def get_context_data(self, **kwargs):
        context = super(SeriesCreate, self).get_context_data(**kwargs)
        context['creating'] = True
        return context    



class SeriesEdit(UpdateView):
    model = Series
    form_class = SeriesForm
    # success_url = "/"
    template_name = 'series/edit.html'

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

def series_delete(request, slug):
    series = Series.objects.get(slug=slug)

    # throw him out if he's not an author
    if request.user != series.author:
        return HttpResponseRedirect('/')        

    series.delete()
    return HttpResponseRedirect('/')



