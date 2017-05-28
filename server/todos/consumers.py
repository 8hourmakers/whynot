import json
import logging
from channels.sessions import channel_session
from .models import TODOItem
from channels import Group
from .tasks import new_chat_receive, update_chat_room_member_num

log = logging.getLogger(__name__)


def get_topic_from_path(message_path):
    path_particle = message_path.split('/')
    if len(path_particle) == 6:
        group_name = path_particle[-2]
        return group_name
    else:
        return None

@channel_session
def ws_connect(message):
    print(message.reply_channel.name)
    message.reply_channel.send({
        "text": json.dumps({
            "action": "reply_channel",
            "reply_channel": message.reply_channel.name,
        })
    })
    topic_id = get_topic_from_path(message.content['path'])
    if topic_id is not None:
        Group(topic_id).add(message.reply_channel)
        update_chat_room_member_num(topic_id, 1)

@channel_session
def ws_disconnect(message):
    print('ws disconnected', message.content)
    topic_id = get_topic_from_path(message.content['path'])
    if topic_id is not None:
        Group(topic_id).discard(message.reply_channel)
        update_chat_room_member_num(topic_id, -1)


@channel_session
def ws_receive(message):
    try:
        topic_id = get_topic_from_path(message.content['path'])
        if topic_id is not None:
            data = json.loads(message['text'])
            if data['action'] == 'new_chat_send':
                payload = data['payload']
                new_chat_receive(topic_id, payload['user_id'], payload['content'])
    except ValueError:
        log.debug("ws message isn't json text=%s", message['text'])
        return

