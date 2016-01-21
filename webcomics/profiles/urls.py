from django.conf.urls import url

from . import views

urlpatterns = [
    url('^login/$', views.login_or_signup),
    url(r'^logout/', 'django.contrib.auth.views.logout'), # , {'next_page':'/'}

    url('^register/$', views.register),
    url(r'^authenticate/', views.authenticate_user),

]
