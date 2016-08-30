import itertools
import datetime
from django.utils.timezone import utc

from django.db import models
from django.template.defaultfilters import slugify
from django.conf import settings
from django.db.models import permalink
from django.core.files.base import ContentFile

from sorl.thumbnail import ImageField
from sorl.thumbnail import get_thumbnail


from categories.models import Category
from series.models import Series

from .utils import rank_hot,next_or_prev_in_order #, unique_slugify

def generate_filename(self,filename):
    url = "videos/%s/%s" % (self.author.username,filename)
    return url

class Video(models.Model):
    title = models.CharField(max_length=256)
    slug = models.SlugField(max_length=256, default="")
    published = models.BooleanField(default=False, blank=True)
    pub_date = models.DateTimeField(auto_now_add=True)

    video = models.FileField(upload_to=generate_filename, default=None,blank=True, null=True)
    thumbnail = models.ImageField(upload_to='videos/thumbnails/',
                                  default=None,blank=True, null=True)

    video_url = models.CharField(max_length=256, default="", blank=True, null=True)
    
    description = models.TextField(default="", null=True, blank=True)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="videos", default="")

    categories = models.ManyToManyField('categories.Category', related_name="videos", blank=True)

    hubs = models.ManyToManyField('hubs.Hub', related_name="videos",
                            default=None, blank=True, null=True)


    series = models.ForeignKey('series.Series', related_name="videos",
                               default=None, blank=True, null=True)

    
    score = models.IntegerField(default=0)
    views = models.IntegerField(default=0)

    digitalverse = models.BooleanField(default=False)    

    def __str__(self):
        return self.title

    # def get_thumb(self):
    #     im = get_thumbnail(self.image, '200x200', crop='center', quality=99)
    #     return im.url # remember that sorl objects have url/width/height attributes    

    
    def save(self, slug="", *args, **kwargs):
        # Slug
        if slug != "":
            self.slug = slug            
        else:
            if self.pk is None:
                self.slug = orig = slugify(self.title)
                # unique_slugify(self, orig) 
                for x in itertools.count(1):
                    if not Video.objects.filter(slug=self.slug).exists():
                        break
                    self.slug = '%s-%d' % (orig, x)            

        # Pub date
        if not self.id:
            self.pub_date = datetime.datetime.now()

        # Create thumbnail
        # if not self.id:  
        # super(Video, self).save(*args, **kwargs)
        # resized = get_thumbnail(image.image, "400x400", crop='center', quality=99)
        # self.thumbnail.save(resized.name, ContentFile(resized.read()), True)            

        return super(Video, self).save(*args, **kwargs)


    def prev_by_author(self, loop=False):
        qs = Video.objects.filter(series=self.series, published=True)# .order_by('-pub_date')
        return next_or_prev_in_order(self, True, qs)

    def next_by_author(self, loop=False):
        qs = Video.objects.filter(series=self.series, published=True)# .order_by('-pub_date')
        return next_or_prev_in_order(self, False, qs)

    @permalink
    def get_absolute_url(self):
        return ('video-detail', None, {'slug': self.slug })

    class Meta:
        ordering = ["pub_date"]    


