from django.conf.urls import include, url
from django.contrib import admin

from django.conf import settings
from django.conf.urls.static import static

# from posts import urls as posts_urls
from videos import urls as videos_urls
from series import urls as series_urls
from hubs import urls as hubs_urls
from profiles import urls as profiles_urls
from comments import urls as comments_urls
from forum import urls as forum_urls

from . import views

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^about/', views.about),
    url(r'^lumen/', views.lumen),        

    url(r'', include(profiles_urls)),        
    # url(r'', include(posts_urls)),
    url(r'', include(videos_urls)),    
    url(r'', include(series_urls)),
    url(r'', include(hubs_urls)),        
    url(r'', include(comments_urls)),
    url(r'', include(forum_urls)),    

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
