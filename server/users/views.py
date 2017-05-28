from rest_framework.response import Response
from rest_framework import status
from django.http import HttpResponse
from rest_framework.views import APIView
from django.utils.crypto import get_random_string

from rest_framework.authtoken.models import Token
from django.contrib.auth import (
    authenticate,
    get_user_model,
    login,
    logout,

    )

from rest_framework.mixins import DestroyModelMixin, UpdateModelMixin
from rest_framework.generics import (
    CreateAPIView,
    DestroyAPIView,
    ListAPIView, 
    UpdateAPIView,
    RetrieveAPIView,
    RetrieveUpdateAPIView,
    RetrieveUpdateDestroyAPIView
    )
from rest_framework.permissions import (
    AllowAny,
    IsAuthenticated,
    IsAdminUser,
    IsAuthenticatedOrReadOnly,
)

User = get_user_model()

from .serializers import UserSerializer


class UserCreateAPIView(CreateAPIView):
    """
    Create a new user
    """
    permission_classes = [AllowAny]
    serializer_class = UserSerializer

    def post(self, request, format=None):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            token = Token.objects.get_or_create(user=user)
            res_data = {'token': str(token[0])}
            return Response(res_data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserLoginAPIView(APIView):
    permission_classes = [AllowAny]
    serializer_class = UserSerializer

    def post(self, request, *args, **kwargs):
        print('login view')
        data = request.data
        user = authenticate(email=data['email'], password=data['password'])
        if user is None:
            return Response(data={'message': 'Login Failed'}, status=status.HTTP_401_UNAUTHORIZED)

        serializer = UserSerializer(user)
        token = Token.objects.get_or_create(user=user)
        res_data = serializer.data
        res_data['token'] = str(token[0])
        return Response(res_data, status=status.HTTP_200_OK)

    def delete(self, request, *args, **kwargs):
        request.user.auth_token.delete()
        return Response(data={'results': 'Logout Success'}, status=status.HTTP_200_OK)


class UserTokenAPIView(APIView):
    permission_classes = [IsAuthenticated]
    serializer_class = UserSerializer

    def get(self, request, *args, **kwargs):
        serializer = UserSerializer(request.user)
        return Response(data=serializer.data, status=status.HTTP_200_OK)
