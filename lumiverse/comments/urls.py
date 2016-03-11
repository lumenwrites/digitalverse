from django.conf.urls import url

from . import views

urlpatterns = [
    # Comments
    url(r'^comment-submit/(?P<video_slug>[^\.]+)', views.comment_submit),    
    url(r'^reply-submit/(?P<comment_id>[^\.]+)', views.reply_submit),

    url(r'^comment/(?P<comment_id>[^\.]+)/edit', views.comment_edit),
    url(r'^comment/(?P<comment_id>[^\.]+)/delete', views.comment_delete), 

    url(r'^comment-upvote/', views.comment_upvote),
    url(r'^comment-downvote/', views.comment_downvote),
    url(r'^comment-unupvote/', views.comment_unupvote),
    url(r'^comment-undownvote/', views.comment_undownvote),

    url(r'^comment/(?P<comment_id>[^\.]+)/edit', views.comment_edit),
    url(r'^comment/(?P<comment_id>[^\.]+)/delete', views.comment_delete), 
]
