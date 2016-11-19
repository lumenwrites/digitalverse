from django.forms import ModelForm
from django import forms

from .models import Hub

class HubForm(ModelForm):
    class Meta:
        model = Hub
        fields = ['title', 'avatar', 'background', 'description']
        widgets = {
            'title': forms.TextInput(attrs={'placeholder': 'Title'}),
            'description': forms.Textarea(attrs={'placeholder': 'Description (optional)',
                                                 'class': 'description',
                                                 'id': 'description'}),
        }

        


        
