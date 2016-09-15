from django.conf.urls import url
from django.views.generic import RedirectView


from . import views

urlpatterns = [

    # Class Based Views
    # Browse
    url(r'^forum/$', views.BrowseView),        
    # url(r'^user/(?P<username>[^\.]+)/$', views.UserprofileView.as_view()),
    # url(r'^forum/category/(?P<hubslug>[^\.]+)/$', views.HubView.as_view()),
    

    # CRUD Posts
    # url(r'^forum/add/$', views.post_create),
    url(r'^forum/post$', views.PostView, name='view_post'),        
    # url(r'^forum/(?P<post>[^\.]+)/?$', views.post, name='view_post'),    
    # url(r'^forum/(?P<post>[^\.]+)/edit$', views.post_edit),
    # url(r'^forum/(?P<post>[^\.]+)/delete$', views.post_delete),


    # url(r'^upvote/$', views.upvote),
    # url(r'^unupvote/$', views.unupvote),

    # Comments
    # url(r'^forum/(?P<post>[^\.]+)/comment-submit$', views.comment_submit),
    # url(r'^forum/comment/(?P<comment_id>[^\.]+)/reply-submit', views.reply_submit),    
    # url(r'^forum/comment/(?P<comment_id>[^\.]+)/edit', views.comment_edit),
    # url(r'^forum/comment/(?P<comment_id>[^\.]+)/delete', views.comment_delete), 

    # url(r'^comment-upvote/', views.comment_upvote),
    # url(r'^comment-unupvote/', views.comment_unupvote),
    

    # url(r'^user/(?P<username>[^\.]+)/comments$', views.comments_user,
    #     {'filterby': 'comments_user'}),
    
]

