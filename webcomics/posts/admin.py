from django.contrib import admin

from .models import Post, Category


class PostAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',), }
    search_fields = ['title','body']


class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',), }
    class Meta:
        verbose_name_plural = "categories"
    

admin.site.register(Post, PostAdmin)
admin.site.register(Category, CategoryAdmin)


