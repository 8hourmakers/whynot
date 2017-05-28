
from rest_framework.generics import (
    ListCreateAPIView, ListAPIView, RetrieveAPIView, CreateAPIView, RetrieveUpdateDestroyAPIView
    )
from rest_framework.permissions import (
    IsAuthenticated,
)
from rest_framework.status import HTTP_404_NOT_FOUND, HTTP_200_OK
from rest_framework.views import APIView
from .models import TODOItem, ScheduleItem
from .serializers import TODOSerializer
from rest_framework.response import Response
from rest_framework import status
from django.db.models import Q
from .utils import today_date
from categories.models import CategoryItem
from datetime import datetime

class TODOCreateAPIView(CreateAPIView):

    permission_classes = [IsAuthenticated]
    serializer_class = TODOSerializer

    def post(self, *args, **kwargs):
        data = self.request.data
        category = None
        if 'category_id' in data:
            category = CategoryItem.objects.filter(id=data['category_id']).all()[:1]
            if len(category) != 0:
                category = category[0]


        todo_item = TODOItem.objects.create(
            user=self.request.user,
            title = data['title'],
            start_datetime=data['start_datetime'],
            end_datetime=data['end_datetime'],
            repeat_day=data['repeat_day'],
            memo=data['memo'],
            alarm_minutes=data['alarm_minutes'],
            category=category
        )

        todo_item.save()
        serializers = TODOSerializer(todo_item)
        # if serializers.is_valid():
        return Response(data=serializers.data, status=HTTP_200_OK)

        # return Response(data=serializers.error_messages, status=HTTP_404_NOT_FOUND)

class TODORecommendAPIView(ListCreateAPIView):

    permission_classes = [IsAuthenticated]
    serializer_class = TODOSerializer

    def get_queryset(self, *args, **kwargs):
        category_id = self.request.GET.get('category_id', None)

        queryset_list = TODOItem.objects.filter(user=None)
        if category_id:
            queryset_list = queryset_list.filter(category__id=category_id)
        return queryset_list

    def post(self, *args, **kwargs):
        data = self.request.data
        category = None
        if 'category_id' in data:
            category = CategoryItem.objects.filter(id=data['category_id']).all()[:1]
            if len(category) != 0:
                category = category[0]

        todo_item = TODOItem.objects.create(
            title = data['title'],
            start_datetime=data['start_datetime'],
            end_datetime=data['end_datetime'],
            repeat_day=data['repeat_day'],
            memo=data['memo'],
            alarm_minutes=data['alarm_minutes'],
            category=category
        )

        todo_item.save()
        serializers = TODOSerializer(todo_item)
        # if serializers.is_valid():
        return Response(data=serializers.data, status=HTTP_200_OK)

class TODORetrieveUpdateDestroyAPIView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = TODOSerializer
    lookup_field = 'id'
    queryset = TODOItem.objects.all()

    def put(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)


class TODOScheduleListAPIView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = TODOSerializer

    def get_queryset(self, *args, **kwargs):
        search_query = self.request.GET.get('query', '')
        # TODO :
        queryset_list = TODOItem.objects.filter(Q(user=self.request.user)&(
            Q(scheduleitem__status='UNCOMPLETE') |
            Q(scheduleitem__datetime__date=today_date())
        )).all()
        return queryset_list

class ScheduleDoneAPIView(APIView):

    def post(self, id, *args, **kwargs):
        schedule = ScheduleItem.objects.filter(id=id).all()[:1]
        if len(schedule) == 0:
            return Response(status=HTTP_404_NOT_FOUND)
        schedule.status = 'COMPELTE'
        schedule.save()
        return Response(status=HTTP_200_OK)
