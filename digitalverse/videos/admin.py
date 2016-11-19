from django.contrib import admin

from .models import Video


class VideoAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',), }
    search_fields = ['title','body']

admin.site.register(Video, VideoAdmin)




