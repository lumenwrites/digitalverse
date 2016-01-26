from django.contrib import admin

from .models import Post, Image


class PostAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',), }
    search_fields = ['title','body']

class ImageAdmin(admin.ModelAdmin):
    pass

admin.site.register(Post, PostAdmin)
admin.site.register(Image, ImageAdmin)



