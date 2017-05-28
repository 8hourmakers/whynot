from __future__ import unicode_literals

from django.db import models
from users.models import User

class TODOItem(models.Model):
    title = models.CharField(max_length=100, null=False)
    start_datetime = models.DateTimeField(null=True, blank=True)
    end_datetime = models.DateTimeField(null=True, blank=True)
    repeat_day = models.IntegerField(null=True, blank=True)
    memo = models.TextField(null=True, blank=True)
    alarm_minutes = models.IntegerField(default=0)
    category = models.ForeignKey('categories.CategoryItem')
    user = models.ForeignKey('users.User', null=True, blank=True)
    timestamp = models.DateTimeField(auto_now=False, auto_now_add=True)

    def __str__(self):
        return self.title

class ScheduleItem(models.Model):
    STATUS_CHOICES = (
        ('UNCOMPLETE', 'UNCOMPLETE'),
        ('COMPLETE', 'COMPLETE'),
        ('TODO', 'TODO')
    )

    todo = models.ForeignKey('todos.TODOItem')
    status = models.CharField(max_length=10, default='TODO', choices=STATUS_CHOICES)
    datetime = models.DateTimeField(null=False)

