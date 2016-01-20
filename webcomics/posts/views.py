from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView

from django.shortcuts import render, redirect
from django.utils import timezone

from .forms import PostForm
from .models import Post


class PostListView(ListView):
    model = Post
    template_name = "posts/browse.html"
    
    def get_context_data(self, **kwargs):
        context = super(PostListView, self).get_context_data(**kwargs)
        context['now'] = timezone.now()
        return context

class PostDetailView(DetailView):
    model = Post
    template_name = "posts/post.html"
    
    def get_context_data(self, **kwargs):
        context = super(PostDetailView, self).get_context_data(**kwargs)
        context['now'] = timezone.now()
        return context    
    
class PostCreate(View):
    form_class = PostForm
    success_url = "/"
    template_name = 'posts/edit.html'

    def get(self, request, *args, **kwargs):
        form = self.form_class()
        return render(request, self.template_name, {'form': form})

    def post(self, request, *args, **kwargs):
        form = self.form_class(request.POST, request.FILES)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            post.save()
            return redirect(self.success_url)
        else:
            return render(request, self.template_name, {'form': form})

        

def testview(request):
    return render(request, 'profiles/profile.html', {
    })
        

