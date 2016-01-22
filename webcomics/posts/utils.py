import datetime
from django.utils.timezone import utc

from functools import reduce
from django.db import models



def hot_score(post, gravity=1.8, timebase=120):
    rating = (post.score + 1)**0.8
    now = datetime.datetime.utcnow().replace(tzinfo=utc)
    age = int((now - post.pub_date).total_seconds())/60
    scr = rating/(age+timebase)**gravity
    return scr

def rank_hot(posts):
    posts = posts.order_by('-pub_date')[:180] # 180 latest posts
    ranked_posts = sorted(posts, key=hot_score, reverse = True)
    return ranked_posts


def get_model_attr(instance, attr):
    """Example usage: get_model_attr(instance, 'category__slug')"""
    for field in attr.split('__'):
        instance = getattr(instance, field)
    return instance

def next_or_prev_in_order(instance, prev=False, qs=None, loop=False):
    """Get the next (or previous with prev=True) item for instance, from the
       given queryset (which is assumed to contain instance) respecting
       queryset ordering. If loop is True, return the first/last item when the
       end/start is reached. """

    if not qs:
        qs = instance.__class__.objects
    if prev:
        qs = qs.reverse()
        lookup = 'lt'
    else:
        lookup = 'gt'

    q_list = []
    prev_fields = []
    if qs.model._meta.ordering:
        ordering = list(qs.model._meta.ordering)
    else:
        ordering = []

    for field in (ordering + ['pub_date']):
        if field[0] == '-':
            this_lookup = (lookup == 'gt' and 'lt' or 'gt')
            field = field[1:]
        else:
            this_lookup = lookup
        q_kwargs = dict([(f, get_model_attr(instance, f))
                         for f in prev_fields])
        key = "%s__%s" % (field, this_lookup)
        q_kwargs[key] = get_model_attr(instance, field)
        q_list.append(models.Q(**q_kwargs))
        prev_fields.append(field)
    try:
        return qs.filter(reduce(models.Q.__or__, q_list))[0]
    except IndexError:
        length = qs.count()
        if loop and length > 1:
            # queryset is reversed above if prev
            return qs[0]
    return None
