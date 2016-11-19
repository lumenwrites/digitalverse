from django.db import models

from django.db import models

from django.template.defaultfilters import slugify    

class Hub(models.Model):
    title = models.CharField(max_length=64)    
    slug = models.SlugField(max_length=64, default="")

    avatar = models.ImageField(upload_to='hubs/avatars/',
                                  default=None,blank=True, null=True)

    background = models.ImageField(upload_to='hubs/backgrounds/',
                                   default=None,blank=True, null=True) 

    description = models.TextField(default="", null=True, blank=True)    
    
    
    def __str__(self):
        return self.title        

    def save(self, *args, **kwargs):
        self.slug = slugify(self.title)
        super(Hub, self).save(*args, **kwargs)
    

