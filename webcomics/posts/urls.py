from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.BrowseView.as_view(), name='post-list'),
    url(r'^browse/$', views.BrowseView.as_view(), name='post-list'),    
    url(r'^subscriptions/$', views.SubscriptionsView.as_view(), name='subscriptions'),    
    url(r'^user/(?P<username>[^\.]+)?/$', views.ProfileView.as_view(), name='profile'),
    


    url(r'^upload/$', views.PostCreate.as_view(), name='post-create'),
    url(r'^post/(?P<slug>[^\.]+)/edit$', views.PostEdit.as_view()),
    url(r'^post/(?P<slug>[^\.]+)/delete$', views.post_delete),    
    url(r'^post/(?P<slug>[^\.]+)/publish$', views.post_publish),
    url(r'^post/(?P<slug>[^\.]+)/unpublish$', views.post_unpublish),        
    url(r'^post/(?P<slug>[^\.]+)$', views.PostDetailView.as_view(), name='post-detail'),

    url(r'^test/$', views.testview, name='post-create'),

    url(r'^upvote/$', views.upvote),
    url(r'^unupvote/$', views.unupvote),
]
