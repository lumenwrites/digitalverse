from django.forms import ModelForm
from django import forms

from .models import Post

class PostForm(ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'image', 'thumbnail', 'description', 'categories']
        widgets = {
            'title': forms.TextInput(attrs={'placeholder': 'Title'}),
            'description': forms.Textarea(attrs={'placeholder': 'Description (optional)',
                                                 'class': 'description',
                                                 'id': 'description'}),
        }

        



        
