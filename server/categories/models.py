from __future__ import unicode_literals

from django.db import models
from django.contrib.auth import get_user_model

class CategoryItem(models.Model):
    name = models.CharField(null=False, max_length=100)
    image = models.ImageField(null=True, blank=True)

    def __str__(self):
        return self.name
