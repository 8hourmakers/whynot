from .models import TODOItem, ScheduleItem
from categories.models import CategoryItem
from categories.serializers import CategorySerializer
from django.db.models import Q
from rest_framework.serializers import (
    CharField,
    EmailField,
    DateField,
    IntegerField,
    BooleanField,
    HyperlinkedIdentityField,
    ModelSerializer,
    DateTimeField,
    Serializer,
    SerializerMethodField,
    ValidationError
    )
import logging
from datetime import datetime
from .utils import today_date


class TODOSerializer(ModelSerializer):

    category = CategorySerializer(required=False)
    start_datetime = CharField()
    end_datetime = CharField()

    class Meta:
        model = TODOItem
        fields = ('id', 'title', 'start_datetime', 'end_datetime', 'repeat_day', 'memo', 'alarm_minutes', 'category')
        read_only_fields = ('id', 'schedules', 'category')


    def get_start_datetime(self, obj):
        return obj.datetime.strftime("%Y-%m-%d %H:%M:%S")

    def get_end_datetime(self, obj):
        return obj.datetime.strftime("%Y-%m-%d %H:%M:%S")

    def validate_category(self, value):
        print(value)
        return value

    def validate_start_datetime(self, value):
        try:
            print(len(value))
            if len(value) <= 10:
                start_datetime = datetime.strptime(value, '%Y-%m-%d')
            else:
                start_datetime = datetime.strptime(value, '%Y-%m-%d %H:%M:%S')
        except Exception as e:
            print(e)
            raise ValidationError("Wrong formated start_datetime")
        return start_datetime

    def validate_end_datetime(self, value):
        try:
            print(len(value))
            if len(value) <= 10:
                end_datetime = datetime.strptime(value, '%Y-%m-%d')
            else:
                end_datetime = datetime.strptime(value, '%Y-%m-%d %H:%M:%S')
        except:
            raise ValidationError("Wrong formated end_datetime")
        return end_datetime


class TODOScheduleSerializer(ModelSerializer):
    schedules = SerializerMethodField()
    category = CategorySerializer(required=False)
    start_datetime = SerializerMethodField()
    end_datetime = SerializerMethodField()

    class Meta:
        model = TODOItem
        fields = ('id', 'title', 'start_datetime', 'end_datetime', 'repeat_day', 'memo', 'alarm_minutes', 'category',
                  'schedules')
        read_only_fields = ('id', 'schedules', 'category')


    def get_schedules(self, obj):
        schedules = ScheduleItem.objects.filter(Q(todo=obj) & (
            Q(status='UNCOMPLETE') |
            ( Q(status='TODO') & Q(datetime__date=today_date()))
        )).all()

        serializers = ScheduleSerializer(schedules, many=True)
        return serializers.data

    def get_start_datetime(self, obj):
        return obj.start_datetime.strftime("%Y-%m-%d %H:%M:%S")

    def get_end_datetime(self, obj):
        return obj.end_datetime.strftime("%Y-%m-%d %H:%M:%S")


class ScheduleSerializer(ModelSerializer):
    datetime = SerializerMethodField()

    class Meta:
        model = ScheduleItem
        fields = ['id', 'datetime', 'status']

    def get_datetime(self, obj):
        return obj.datetime.strftime("%Y-%m-%d %H:%M:%S")
