from django.forms import ModelForm
from django import forms

from .models import Video
from series.models import Series


class VideoForm(ModelForm):

    class Meta:
        model = Video
        fields = ['title', 'video','video_url', 'thumbnail', 'description', 'categories', 'series']
        widgets = {
            'title': forms.TextInput(attrs={'placeholder': 'Title'}),
            'description': forms.Textarea(attrs={'placeholder': 'Description (optional)',
                                                 'class': 'description',
                                                 'id': 'description'}),
            'video_url': forms.TextInput(attrs={'placeholder': 'Youtube video id'}),            
        }

        



    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user')
        super(VideoForm, self).__init__(*args, **kwargs)
        self.fields['series'].empty_label = "Select Series"

        self.fields['series'].queryset = Series.objects.filter(author=user)
