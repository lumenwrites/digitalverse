from django.conf.urls import url

from .views import BrowseView, SubscriptionsView, ProfileView, PostDetailView, PostCreate, upvote, unupvote, testview

urlpatterns = [
    url(r'^$', BrowseView.as_view(), name='post-list'),
    url(r'^browse/$', BrowseView.as_view(), name='post-list'),    
    url(r'^subscriptions/$', SubscriptionsView.as_view(), name='subscriptions'),    
    url(r'^user/(?P<username>[^\.]+)$', ProfileView.as_view(), name='profile'),
    
    url(r'^post/(?P<slug>[^\.]+)$', PostDetailView.as_view(), name='post-detail'),

    url(r'^upload/$', PostCreate.as_view(), name='post-create'),

    url(r'^test/$', testview, name='post-create'),

    url(r'^upvote/$', upvote),
    url(r'^unupvote/$', unupvote),
]
