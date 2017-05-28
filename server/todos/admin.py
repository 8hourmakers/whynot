from django.contrib import admin

# Register your models here.
from .models import TODOItem, ScheduleItem


class TODOModelAdmin(admin.ModelAdmin):
    list_display = ["title", "start_datetime", "end_datetime", "repeat_day", "memo",
                    "alarm_minutes", "category_id", "user"]
    list_display_links = ["title"]
    list_filter = ["title", "user"]

    class Meta:
        model = TODOItem


class ScheduleModelAdmin(admin.ModelAdmin):
    list_display = ["todo", "status", "datetime"]

    class Meta:
        model = ScheduleItem

admin.site.register(TODOItem, TODOModelAdmin)
admin.site.register(ScheduleItem, ScheduleModelAdmin)