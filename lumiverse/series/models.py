import itertools
import datetime
from django.utils.timezone import utc

from django.db import models
from django.template.defaultfilters import slugify
from django.conf import settings

from sorl.thumbnail import ImageField

from categories.models import Category

class Series(models.Model):
    title = models.CharField(max_length=256)
    slug = models.SlugField(max_length=256, default="")
    published = models.BooleanField(default=False, blank=True)
    pub_date = models.DateTimeField(auto_now_add=True)

    image = models.ImageField(upload_to='series/avatars/',
                                  default=None,blank=True, null=True)    


    background = models.ImageField(upload_to='series/backgrounds/',
                                   default=None,blank=True, null=True) 

    description = models.TextField(default="", null=True, blank=True)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="series", default="")

    categories = models.ManyToManyField('categories.Category', related_name="series", blank=True)
    hubs = models.ManyToManyField('hubs.Hub', related_name="series", blank=True)
    score = models.IntegerField(default=0)
    views = models.IntegerField(default=0)

    
    def __str__(self):
        return self.title

    def save(self, slug="", *args, **kwargs):
        # Slug
        if slug != "":
            self.slug = slug            
        else:
            if self.pk is None:
                self.slug = orig = slugify(self.title)
                # unique_slugify(self, orig) 
                for x in itertools.count(1):
                    if not Series.objects.filter(slug=self.slug).exists():
                        break
                    self.slug = '%s-%d' % (orig, x)            

        # Pub date
        if not self.id:
            self.pub_date = datetime.datetime.now()


        return super(Series, self).save(*args, **kwargs)

