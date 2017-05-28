from .models import CategoryItem
from rest_framework.serializers import (
    CharField,
    EmailField,
    DateField,
    IntegerField,
    BooleanField,
    HyperlinkedIdentityField,
    ModelSerializer,
    Serializer,
    SerializerMethodField,
    ValidationError
    )
import logging


class CategorySerializer(ModelSerializer):
    class Meta:
        model = CategoryItem
        fields = ['id', 'name', 'image']
