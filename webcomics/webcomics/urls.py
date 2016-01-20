from django.conf.urls import include, url
from django.contrib import admin

from django.conf import settings
from django.conf.urls.static import static

from posts import urls as posts_urls

from . import views

urlpatterns = [
    url(r'^admin/', admin.site.urls),

    url(r'', include(posts_urls)),    
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
