import datetime
from django.utils.timezone import utc

from django.db import models
from django.template.defaultfilters import slugify
from django.conf import settings
from django.db.models import permalink
from django.core.files.base import ContentFile

from sorl.thumbnail import ImageField
from sorl.thumbnail import get_thumbnail


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

    # categories = models.ManyToManyField('categories.Category', related_name="posts", blank=True)
    score = models.IntegerField(default=0)

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
            self.slug = slugify(self.title)

        # Pub date
        if not self.id:
            self.pub_date = datetime.datetime.now()

        # Create thumbnail
        if not self.id:  
            super(Post, self).save(*args, **kwargs)  
            resized = get_thumbnail(self.image, "400x400", crop='center', quality=99)
            self.thumbnail.save(resized.name, ContentFile(resized.read()), True)            

        return super(Post, self).save(*args, **kwargs)

    @permalink
    def get_absolute_url(self):
        return ('post-detail', None, {'slug': self.slug })        
    
