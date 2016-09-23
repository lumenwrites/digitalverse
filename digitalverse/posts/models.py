import datetime
import uuid

from django.db import models
from django.db.models import permalink
from django.conf import settings
from django.template.defaultfilters import slugify


class Post(models.Model):
    title = models.CharField(max_length=256)
    slug = models.SlugField(max_length=256, default="")
    published = models.BooleanField(default=True, blank=True)
    pub_date = models.DateTimeField(blank=True)
    # updated = models.DateTimeField(default=datetime.datetime.now, blank=True)    
    body = models.TextField(default="", null=True, blank=True)
    author = models.ForeignKey(settings.AUTH_USER_MODEL, related_name="posts", default="")

    categories = models.ManyToManyField('Category', related_name="posts", blank=True)
    score = models.IntegerField(default=0)
    views = models.IntegerField(default=0)


    dvblog = models.BooleanField(default=False, blank=True)
    
    def __str__(self):
        return self.title

    def save(self, slug="", *args, **kwargs):
        if not self.id:
            self.pub_date = datetime.datetime.now()


        # Unique slug
        if self.pk is None:            
            if slug:
                # If I'm passing a slug - just use it.
                # As it stands - don't need it, I'm never editing it once created.
                self.slug = slug            
            else:
                # If not - slugify title
                self.slug = orig = slugify(self.title)
                # Come up with unique id
                while True:
                    # If the post is unique now - it's done, if not - come up with another one
                    if not Post.objects.filter(slug=self.slug).exists():
                        break
                    # Generate random id
                    uniqueid = uuid.uuid1().hex[:5]
                    self.slug = orig + "-" + str(uniqueid)
                    

        return super(Post, self).save(*args, **kwargs)
    
    @permalink
    def get_absolute_url(self):
        return ('view_post', None, {'slug': self.slug })


class Category(models.Model):
    title = models.CharField(max_length=64)    
    slug = models.SlugField(max_length=64, default="")
    # description = models.TextField(max_length=512, blank=True)
    # order = models.IntegerField(default=0)
    
    def __str__(self):
        return self.title        

    def save(self, *args, **kwargs):
        self.slug = slugify(self.title)
        super(Category, self).save(*args, **kwargs)
    

