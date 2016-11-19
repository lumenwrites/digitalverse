from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^$', views.BrowseView.as_view(), name='post-list'),


    url(r'^create-hub/$', views.HubCreate.as_view(), name='hub-create'),
    url(r'^hub/(?P<slug>[^\.]+)/edit$', views.HubEdit.as_view()),
    url(r'^hub/(?P<slug>[^\.]+)/delete$', views.hub_delete),    

    # url(r'^browse/$', views.BrowseView.as_view(), name='post-list'),

    url(r'^hub/(?P<slug>[^\.]+)/subscribe', views.subscribe),
    url(r'^hub/(?P<slug>[^\.]+)/unsubscribe', views.unsubscribe),    

    
    url(r'^hub/(?P<slug>[^\.]+)$', views.HubView.as_view(), name='hub-detail'),


    url(r'^hubs/', views.HubsBrowse.as_view()),
    
]
