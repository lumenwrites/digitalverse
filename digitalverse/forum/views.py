from django.shortcuts import render


def BrowseView(request):
    return render(request, 'forum/forum.html', {
    })


def PostView(request):
    return render(request, 'forum/post.html', {
    })

