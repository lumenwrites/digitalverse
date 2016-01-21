from django.conf.urls import url

from .views import PostListView, ProfileView, PostDetailView, PostCreate, upvote, unupvote, testview

urlpatterns = [
    url(r'^$', PostListView.as_view(), name='post-list'),
    url(r'^browse/$', PostListView.as_view(), name='post-list'),    
    url(r'^post/(?P<slug>[^\.]+)$', PostDetailView.as_view(), name='post-detail'),
    url(r'^upload/$', PostCreate.as_view(), name='post-create'),
    url(r'^user/(?P<username>[^\.]+)$', ProfileView.as_view(), name='profile'),    
    url(r'^test/$', testview, name='post-create'),

    url(r'^upvote/$', upvote),
    url(r'^unupvote/$', unupvote),
]
