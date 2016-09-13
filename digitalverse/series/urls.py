from django.conf.urls import url

from . import views
from posts.views import SeriesFeed

urlpatterns = [
    # url(r'^$', views.BrowseView.as_view(), name='post-list'),


    url(r'^create-series/$', views.SeriesCreate.as_view(), name='series-create'),
    url(r'^series/(?P<slug>[^\.]+)/edit$', views.SeriesEdit.as_view()),
    url(r'^series/(?P<slug>[^\.]+)/delete$', views.series_delete),    

    # url(r'^browse/$', views.BrowseView.as_view(), name='post-list'),

    url(r'^series/(?P<slug>[^\.]+)/subscribe', views.subscribe),
    url(r'^series/(?P<slug>[^\.]+)/unsubscribe', views.unsubscribe),    

    url(r'^series/(?P<slug>[^\.]+)/feed/atom/$', SeriesFeed()),        
    
    url(r'^series/(?P<slug>[^\.]+)$', views.SeriesView.as_view(), name='series-detail'),


    url(r'^series/', views.SeriesBrowse.as_view()),
    
]
