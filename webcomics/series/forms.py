from django.forms import ModelForm
from django import forms

from .models import Series

class SeriesForm(ModelForm):
    class Meta:
        model = Series
        fields = ['title', 'image', 'background', 'description', 'categories']
        widgets = {
            'title': forms.TextInput(attrs={'placeholder': 'Title'}),
            'description': forms.Textarea(attrs={'placeholder': 'Description (optional)',
                                                 'class': 'description',
                                                 'id': 'description'}),
        }

        


        
