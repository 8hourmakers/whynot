import re
from datetime import datetime

from django.contrib.contenttypes.models import ContentType
from django.contrib.auth import get_user_model
from rest_framework.authtoken.models import Token
from django.contrib.auth import (
    authenticate,
    get_user_model,
    login,
    logout,
    )

from rest_framework.serializers import (
    ModelSerializer,
    )

User = get_user_model()


class UserSerializer(ModelSerializer):

    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password')
        extra_kwargs = {"password": {"write_only": True}}

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user
