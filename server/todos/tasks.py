from __future__ import absolute_import
import time
import json
import logging

from whynot.celery import app
from .models import TODOItem
from channels import Channel, Group
import time as ptime
log = logging.getLogger(__name__)

@app.task
def new_chat_receive(topic_id, user_id, content):
    print('new chat recieve')
    chat_item = TODOItem.objects.create(
        topic_id=topic_id,
        user_id=user_id,
        content=content
    )
    chat_item.save()
    print('save')
    print('Channel Name : ', chat_item.topic.name)
    Group(topic_id).send({
        "text": json.dumps({
            "action": "new_chat_receive",
            "payload": {
                "id": chat_item.id,
                "topic_id": chat_item.topic.id,
                'content': content,
                "user": {
                    'id': chat_item.user.id,
                    'username': chat_item.user.username,
                    'profile_image_url': chat_item.user.profile_image_url,
                },
                "timestamp": chat_item.timestamp.strftime("%Y-%m-%d %H:%M:%S.%f")
            },

        })
    })

@app.task
def update_chat_room_member_num(topic_id, num_diff):
    topic = TODOItem.objects.get(id=topic_id)
    topic.member_num += num_diff
    topic.save()

    Group(topic_id).send({
        "text": json.dumps({
            "action": "update_chat_room_member_num",
            "payload": {
                "topic_id": topic_id,
                "member_num": topic.member_num
            }
        })
    })
