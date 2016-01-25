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



class Post(models.Model):
    title = models.CharField(max_length=256)
    slug = models.SlugField(max_length=256, default="")
    published = models.BooleanField(default=False, blank=True)
    pub_date = models.DateTimeField(auto_now_add=True)

    image = models.ImageField(upload_to='comics/', default=None,blank=True, null=True)
    thumbnail = models.ImageField(upload_to='comics/thumbnails/',
                                  default=None,blank=True, null=True)    
    
    description = models.TextField(default="", null=True, blank=True)

    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="posts", default="")

    categories = models.ManyToManyField('categories.Category', related_name="posts", blank=True)
    series = models.ForeignKey('series.Series', related_name="posts",
                               default=None, blank=True, null=True)
    
    score = models.IntegerField(default=0)
    views = models.IntegerField(default=0)

    def __str__(self):
        return self.title

    def get_thumb(self):
        im = get_thumbnail(self.image, '200x200', crop='center', quality=99)
        return im.url # remember that sorl objects have url/width/height attributes    

    
    def save(self, slug="", *args, **kwargs):
        # Slug
        if slug != "":
            self.slug = slug            
        else:
            if self.pk is None:
                self.slug = orig = slugify(self.title)
                # unique_slugify(self, orig) 
                for x in itertools.count(1):
                    if not Post.objects.filter(slug=self.slug).exists():
                        break
                    self.slug = '%s-%d' % (orig, x)            

        # Pub date
        if not self.id:
            self.pub_date = datetime.datetime.now()

        # Create thumbnail
        if not self.id:  
            super(Post, self).save(*args, **kwargs)  
            resized = get_thumbnail(self.image, "400x400", crop='center', quality=99)
            self.thumbnail.save(resized.name, ContentFile(resized.read()), True)            

        return super(Post, self).save(*args, **kwargs)


    def prev_by_author(self, loop=False):
        qs = Post.objects.filter(series=self.series, published=True)# .order_by('-pub_date')
        return next_or_prev_in_order(self, True, qs)

    def next_by_author(self, loop=False):
        qs = Post.objects.filter(series=self.series, published=True)# .order_by('-pub_date')
        return next_or_prev_in_order(self, False, qs)

    @permalink
    def get_absolute_url(self):
        return ('post-detail', None, {'slug': self.slug })

    class Meta:
        ordering = ["pub_date"]    
