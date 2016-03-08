from posts.models import Post, Image

posts = Post.objects.all()
for post in posts:
    if post.image:
        Image.objects.create(image=post.image, post=post)
    
