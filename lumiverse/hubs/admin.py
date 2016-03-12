from django.contrib import admin

from .models import Hub


class HubAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('title',), }
    class Meta:
        verbose_name_plural = "hubs"
    


admin.site.register(Hub, HubAdmin)


