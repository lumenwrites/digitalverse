from django.conf.urls import url
from django.views.generic import RedirectView


from . import views
# from .feeds import MainFeed

urlpatterns = [

    # User Feed
    # url(r'^user/(?P<username>[^\.]+)/feed/atom/$', feeds.UserFeed()),    

    # url(r'^$', views.BlogView.as_view()),    


    # Class Based Views
    # Browse
    url(r'^forum/$', views.BrowseView.as_view()),
    url(r'^community/$', views.BrowseView.as_view()),
    url(r'^blog/$', views.BlogView.as_view()),            
    url(r'^profile/(?P<username>[^\.]+)$', views.UserprofileView.as_view()),
    # url(r'^forum/category/(?P<hubslug>[^\.]+)/$', views.HubView.as_view()),
    

    # CRUD Posts
    url(r'^post/add$', views.post_create),
    url(r'^post/(?P<slug>[^\.]+)/edit$', views.post_edit),
    url(r'^post/(?P<post>[^\.]+)/delete$', views.post_delete),
    url(r'^post/(?P<slug>[^\.]+)/?$', views.post, name='view_post'),



    url(r'^post-upvote/$', views.upvote),
    url(r'^post-unupvote/$', views.unupvote),

    # Comments
    # url(r'^forum/(?P<post>[^\.]+)/comment-submit$', views.comment_submit),
    # url(r'^forum/comment/(?P<comment_id>[^\.]+)/reply-submit', views.reply_submit),    
    # url(r'^forum/comment/(?P<comment_id>[^\.]+)/edit', views.comment_edit),
    # url(r'^forum/comment/(?P<comment_id>[^\.]+)/delete', views.comment_delete), 

    # url(r'^comment-upvote/', views.comment_upvote),
    # url(r'^comment-unupvote/', views.comment_unupvote),
    

    # url(r'^user/(?P<username>[^\.]+)/comments$', views.comments_user,
    #     {'filterby': 'comments_user'}),



    # url(r'^upvote/$', views.upvote),
    # url(r'^unupvote/$', views.unupvote),


]



