from django.conf.urls import url
from django.contrib.auth.views import logout

from .views import login_or_signup, register, authenticate_user, preferences, update_password, about, subscribe, unsubscribe

urlpatterns = [
    url('^login/$', login_or_signup),
    url(r'^logout/', logout), # , {'next_page':'/'}

    url('^register/$', register),
    url(r'^authenticate/', authenticate_user),

    url(r'^preferences/$', preferences),
    # url(r'^user/(?P<slug>[^\.]+)/preferences$', views.UserEdit.as_view()),    
    url(r'^update-password/$', update_password),

    url(r'^user/(?P<username>[^\.]+)/about$', about),        

    url(r'^user/(?P<username>[^\.]+)/subscribe', subscribe),
    url(r'^user/(?P<username>[^\.]+)/unsubscribe', unsubscribe),    
]
