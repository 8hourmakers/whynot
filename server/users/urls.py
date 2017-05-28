from django.conf.urls import url
from django.contrib import admin

from .views import (
    UserCreateAPIView,
    UserLoginAPIView,
    UserTokenAPIView
    )

urlpatterns = [
    url(r'^$', UserCreateAPIView.as_view(), name='create_user'),
    url(r'^auth/$', UserLoginAPIView.as_view(), name='login_user'),
    url(r'^auth/token/$', UserTokenAPIView.as_view(), name='token_user'),
]
