from django.conf.urls import url
from .views import CategoryListAPIView

urlpatterns = [
    url(r'^$', CategoryListAPIView.as_view(), name='category_list'),
]
