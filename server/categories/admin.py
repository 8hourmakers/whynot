from django.contrib import admin

# Register your models here.
from .models import CategoryItem


class CategoryModelAdmin(admin.ModelAdmin):
    list_display = ["id", "name", "image"]
    list_display_links = ["name"]

    class Meta:
        model = CategoryItem

admin.site.register(CategoryItem, CategoryModelAdmin)