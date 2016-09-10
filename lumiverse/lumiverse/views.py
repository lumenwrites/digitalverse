from django.shortcuts import render

def home(request):
    return render(request, 'home.html', {
    })



def about(request):
    return render(request, 'about.html', {
    })

def lumen(request):
    return render(request, 'lumen.html', {
    })
