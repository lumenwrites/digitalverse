from django.views.generic import View
from django.views.generic.list import ListView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView

from django.shortcuts import render, redirect
from django.utils import timezone

from profiles.models import User 
from .forms import PostForm
from .models import Post, Category


from .utils import rank_hot

class PostListView(ListView):
    model = Post
    template_name = "posts/browse.html"

    def get_queryset(self):
        qs = super(PostListView, self).get_queryset()

        # Filter published
        qs = qs.filter(published=True)

        # Filter by category
        category = self.request.GET.get('category')
        if category:
            category = Category.objects.get(slug=category)
            qs = qs.filter(categories=category)

        # Sort
        sorting = self.request.GET.get('sorting')
        if sorting == 'top':
            qs = qs.order_by('-score')
        elif sorting == 'new':
            qs = qs.order_by('-pub_date')
        else:
            qs = rank_hot(qs)

        return qs

    def get_context_data(self, **kwargs):
        context = super(PostListView, self).get_context_data(**kwargs)
        context['now'] = timezone.now()
        context['sorting'] = self.request.GET.get('sorting')
        context['category'] = self.request.GET.get('category')
        context['categories'] = Category.objects.all()
        return context

class ProfileView(ListView):
    model = Post
    template_name = "posts/profile.html"

    def get_queryset(self):
        qs = super(ProfileView, self).get_queryset()

        # Filter published
        qs = qs.filter(published=True)

        # Filter by category
        category = self.request.GET.get('category')
        if category:
            category = Category.objects.get(slug=category)
            qs = qs.filter(categories=category)

        # Sort
        sorting = self.request.GET.get('sorting')
        if sorting == 'top':
            qs = qs.order_by('-score')
        elif sorting == 'new':
            qs = qs.order_by('-pub_date')
        else:
            qs = rank_hot(qs)

        return qs

    def get_context_data(self, **kwargs):
        context = super(ProfileView, self).get_context_data(**kwargs)
        context['now'] = timezone.now()
        context['sorting'] = self.request.GET.get('sorting')
        context['category'] = self.request.GET.get('category')
        context['categories'] = Category.objects.all()

        userprofile = User.objects.get(username=self.kwargs['username'])
        context['userprofile'] = userprofile
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
    return render(request, 'posts/profile.html', {
    })
        

