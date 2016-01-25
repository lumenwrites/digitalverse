from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.BrowseView.as_view(), name='post-list'),


    url(r'^create-series/$', views.PostCreate.as_view(), name='post-create'),
    url(r'^series/(?P<slug>[^\.]+)/edit$', views.PostEdit.as_view()),
    url(r'^series/(?P<slug>[^\.]+)/delete$', views.post_delete),    

    # url(r'^browse/$', views.BrowseView.as_view(), name='post-list'),    
    url(r'^series/(?P<slug>[^\.]+)$', views.PostDetailView.as_view(), name='post-detail'),

]
