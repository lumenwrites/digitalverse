from django.forms import ModelForm
from django import forms

from .models import Post
from series.models import Series

class PostForm(ModelForm):
    class Meta:
        model = Post
        fields = ['title', 'image', 'thumbnail', 'description', 'categories', 'series']
        widgets = {
            'title': forms.TextInput(attrs={'placeholder': 'Title'}),
            'description': forms.Textarea(attrs={'placeholder': 'Description (optional)',
                                                 'class': 'description',
                                                 'id': 'description'}),
        }

        



    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user')
        super(PostForm, self).__init__(*args, **kwargs)
        self.fields['series'].empty_label = "Select Series"

        self.fields['series'].queryset = Series.objects.filter(author=user)
