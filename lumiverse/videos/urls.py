from django.conf.urls import url

from . import views

urlpatterns = [

    # Store
    url(r'^user/rayalez/store/$', views.item),
    
    url(r'^$', views.BrowseView.as_view(), name='video-list'),
    url(r'^browse/$', views.BrowseView.as_view(), name='video-list'),    
    url(r'^subscriptions/$', views.SubscriptionsView.as_view(), name='subscriptions'),    


    url(r'^user/(?P<username>[^\.]+)/feed/atom/$', views.UserFeed()),    

    url(r'^user/(?P<username>[^\.]+)?/$', views.ProfileView.as_view(), name='profile'),
    url(r'^user/(?P<username>[^\.]+)$', views.ProfileView.as_view(), name='profile'),
    


    # url(r'^upload/$', views.VideoCreate.as_view(), name='video-create'),
    url(r'^upload/$', views.video_create, name='video-create'),    
    # url(r'^video/(?P<slug>[^\.]+)/edit$', views.VideoEdit.as_view()),
    url(r'^video/(?P<slug>[^\.]+)/edit$', views.video_edit),    
    url(r'^video/(?P<slug>[^\.]+)/delete$', views.video_delete),    
    url(r'^video/(?P<slug>[^\.]+)/publish$', views.video_publish),
    url(r'^video/(?P<slug>[^\.]+)/unpublish$', views.video_unpublish),        
    url(r'^video/(?P<slug>[^\.]+)$', views.VideoDetailView.as_view(), name='video-detail'),

    url(r'^test/$', views.testview, name='video-create'),

    url(r'^upvote/$', views.upvote),
    url(r'^unupvote/$', views.unupvote),
    
]
