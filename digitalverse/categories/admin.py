from django.contrib import admin

from .models import Category


class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',), }
    class Meta:
        verbose_name_plural = "categories"
    


admin.site.register(Category, CategoryAdmin)


