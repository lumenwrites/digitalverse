from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models import permalink

from posts.models import Post

class User(AbstractUser):  
    about = models.TextField(max_length=512, blank=True)
    website = models.CharField(max_length=64, blank=True)

    karma = models.IntegerField(default=0)
    # created = models.DateTimeField(auto_now_add=True, blank=True)

    subscribed = models.ManyToManyField('User', related_name="subscribers", blank=True)

    upvoted = models.ManyToManyField('posts.Post', related_name="upvoters", blank=True)

    # comments_upvoted = models.ManyToManyField('comments.Comment', related_name="upvoters", blank=True)
    # approved = models.BooleanField(default=False)
    
    # @permalink
    # def get_absolute_url(self):
    #     return ('view_post', None, {'slug': self.slug })        
