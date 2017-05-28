from django.conf.urls import url
from .views import TODOCreateAPIView, TODORetrieveUpdateDestroyAPIView, TODOScheduleListAPIView, \
    ScheduleDoneAPIView, TODORecommendAPIView

urlpatterns = [
    url(r'^$', TODOCreateAPIView.as_view(), name='todo_create'),
    url(r'^recommend/$', TODORecommendAPIView.as_view(), name='todo_recommend'),
    url(r'^(?P<id>[0-9]+)/$', TODORetrieveUpdateDestroyAPIView.as_view(), name='todo_detail'),
    url(r'^schedules/$', TODOScheduleListAPIView.as_view(), name='todo_schedule_list'),
    url(r'^schedules/(?P<id>[0-9]+)/done/$', ScheduleDoneAPIView.as_view(), name='schedule_done'),
]
