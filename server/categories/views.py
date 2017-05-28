
from rest_framework.generics import (
    ListCreateAPIView, ListAPIView, DestroyAPIView
    )
from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.permissions import (
    IsAuthenticated,
)
from rest_framework.response import Response
from .models import CategoryItem
from .serializers import CategorySerializer

class CategoryListAPIView(ListCreateAPIView):

    permission_classes = [IsAuthenticated]
    serializer_class = CategorySerializer

    def get_serializer_context(self):
        return {'request': self.request}

    def get_queryset(self, *args, **kwargs):
        queryset_list = CategoryItem.objects.all()
        return queryset_list
