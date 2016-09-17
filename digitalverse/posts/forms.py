import itertools

from django.forms import ModelForm
from django import forms
from django.template.defaultfilters import slugify

from .models import Post


class PostForm(ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'body'] # , 'hubs'
        widgets = {
            'title': forms.TextInput(attrs={'placeholder': 'Title'}),
            'body': forms.Textarea(attrs={'class': 'markdown',
                                          'id': 'markdown'}),            
        }


