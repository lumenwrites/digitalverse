import datetime
from django.utils.timezone import utc

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


class SortMixin(object):
    default_sort_params = None

    def sort_queryset(self, qs, sorting):
        return qs

    def get_default_sorting(self):
        if self.default_sort_params is None:
            raise ImproperlyConfigured(
                "'SortMixin' requires the 'default_sort_params' attribute "
                "to be set.")
        return self.default_sort_params

    def get_sort_params(self):
        default_sorting = self.get_default_sorting()
        sorting = self.request.GET.get('sorting', default_sorting)
        return sorting

    def get_queryset(self):
        return self.sort_queryset(
            super(SortMixin, self).get_queryset(),
            *self.get_sort_params())

    def get_context_data(self, *args, **kwargs):
        context = super(SortMixin, self).get_context_data(*args, **kwargs)
        sorting = self.get_sort_params()
        context.update({
            'sorting': sorting,
        })
        return context    

class FilterMixin(object):
    """
    View mixin which provides filtering for ListView.
    """
    filter_url_kwarg = 'filter'
    default_filter_param = None

    def get_default_filter_param(self):
        if self.default_filter_param is None:
            raise ImproperlyConfigured(
                "'FilterMixin' requires the 'default_filter_param' attribute "
                "to be set.")
        return self.default_filter_param

    def filter_queryset(self, qs, filter_param):
        """
        Filter the queryset `qs`, given the selected `filter_param`. Default
        implementation does no filtering at all.
        """
        return qs

    def get_filter_param(self):
        return self.kwargs.get(self.filter_url_kwarg,
                               self.get_default_filter_param())

    def get_queryset(self):
        return self.filter_queryset(
            super(FilterMixin, self).get_queryset(),
            self.get_filter_param())

    def get_context_data(self, *args, **kwargs):
        context = super(FilterMixin, self).get_context_data(*args, **kwargs)
        context.update({
            'filter': self.get_filter_param(),
        })
        return context

