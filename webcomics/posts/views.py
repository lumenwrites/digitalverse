from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView

from django.shortcuts import render, redirect
from django.utils import timezone

from .forms import PostForm
from .models import Post

from .utils import rank_hot

class PostListView(ListView):
    model = Post
    template_name = "posts/browse.html"

    def get_queryset(self):
        sorting = self.request.GET.get('sorting')
        filterby = self.request.GET.get('filterby')
        if sorting == 'top':
            qs = super(PostListView, self).get_queryset().order_by('-score')
        elif sorting == 'new':
            qs = super(PostListView, self).get_queryset().order_by('-pub_date')
        else:
            # hot
            qs = super(PostListView, self).get_queryset()
            qs = rank_hot(qs)
        return qs

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
        

