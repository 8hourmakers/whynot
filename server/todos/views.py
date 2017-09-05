
from rest_framework.generics import (
    ListCreateAPIView, ListAPIView, RetrieveAPIView, CreateAPIView, RetrieveUpdateDestroyAPIView
    )
from rest_framework.permissions import (
    IsAuthenticated,
)
from rest_framework.status import HTTP_404_NOT_FOUND, HTTP_200_OK, HTTP_406_NOT_ACCEPTABLE
from rest_framework.views import APIView
from .models import TODOItem, ScheduleItem
from .serializers import TODOSerializer, TODOScheduleSerializer
from rest_framework.response import Response
from rest_framework import status
from django.db.models import Q
from .utils import today_date
from categories.models import CategoryItem
from datetime import datetime, timedelta

class TODOCreateAPIView(CreateAPIView):

    permission_classes = [IsAuthenticated]
    serializer_class = TODOSerializer

    def validate_datetime(self, value):
        try:
            if len(value) <= 10:
                start_datetime = datetime.strptime(value, '%Y-%m-%d')
            else:
                start_datetime = datetime.strptime(value, '%Y-%m-%d %H:%M:%S')
        except:
            raise None
        return start_datetime

    def post(self, *args, **kwargs):
        data = self.request.data
        category = None
        if 'category_id' in data:
            category = CategoryItem.objects.filter(id=data['category_id']).first()
            if category is None:
                return Response({'message': 'category not exists'}, status=status.HTTP_404_NOT_FOUND)

        if 'start_datetime' not in data:
            return Response(data={"message": "start_datetime format is invalid"}, status=HTTP_406_NOT_ACCEPTABLE)
        if 'end_datetime' not in data:
            return Response(data={"message": "end_datetime format is invalid"}, status=HTTP_406_NOT_ACCEPTABLE)
        if 'repeat_day' not in data or not isinstance(data['repeat_day'], int):
            return Response(data={"message": "repeat_day is invalid"}, status=HTTP_406_NOT_ACCEPTABLE)
        start_datetime = self.validate_datetime(data['start_datetime'])
        end_datetime = self.validate_datetime(data['end_datetime'])

        todo_item = TODOItem.objects.create(
            user=self.request.user,
            title = data['title'],
            start_datetime=start_datetime,
            end_datetime=end_datetime,
            repeat_day=data['repeat_day'],
            memo=data['memo'],
            alarm_minutes=data['alarm_minutes'],
            category=category
        )
        todo_item.save()

        iter_datetime = start_datetime
        while(iter_datetime <= end_datetime):
            schedule_item = ScheduleItem(
                todo=todo_item,
                status='TODO',
                datetime=iter_datetime
            )
            schedule_item.save()
            iter_datetime += timedelta(days=data['repeat_day'])

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
            category = CategoryItem.objects.filter(id=data['category_id']).first()
            if category is None:
                return Response({'message': 'category not exists'}, status=status.HTTP_404_NOT_FOUND)

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
    serializer_class = TODOScheduleSerializer

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
        schedule = ScheduleItem.objects.filter(id=id).first()
        if schedule is None:
            return Response(status=HTTP_404_NOT_FOUND)
        schedule.status = 'COMPELTE'
        schedule.save()
        return Response(status=HTTP_200_OK)
