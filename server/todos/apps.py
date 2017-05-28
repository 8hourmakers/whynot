from django.apps import AppConfig

INIT_TOPICS = [
    {
        'parent_id': 1,
        'name': '음식',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026193/d78dcec4-3831-11e7-8cf3-a1df05ff8635.png'
    },
    {
        'parent_id': 1,
        'name': '19',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026375/b28e29e0-3834-11e7-8fbf-7da85189f660.png'
    },
    {
        'parent_id': 1,
        'name': '덕질',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026196/e911b7d2-3831-11e7-997f-318a84e809b8.png'
    },

    {
        'parent_id': 1,
        'name': '뷰티',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026197/ef9c4a36-3831-11e7-9c59-bf5a8aa57cf9.png'
    },

    {
        'parent_id': 1,
        'name': '이슈',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026201/f556479c-3831-11e7-8d67-6eefe8c40a8e.png'
    },

    {
        'parent_id': 1,
        'name': '육아',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026197/ef9c4a36-3831-11e7-9c59-bf5a8aa57cf9.png'
    },

    {
        'parent_id': 1,
        'name': '게임',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026269/1d8894da-3833-11e7-8252-84c8b8f2b372.jpg'
    },

    {
        'parent_id': 1,
        'name': '스포츠',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026195/e3c26ba0-3831-11e7-900d-76f5e888c934.png'
    },

    {
        'parent_id': 1,
        'name': '스터디',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026193/d78dcec4-3831-11e7-8cf3-a1df05ff8635.png'
    },

    {
        'parent_id': 1,
        'name': '반려동물',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026191/ca0a6ff0-3831-11e7-819b-893d73690602.png'
    },

    {
        'parent_id': 1,
        'name': '자동차',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026187/b98246c6-3831-11e7-9154-457abbdc6304.png'
    },

    {
        'parent_id': 1,
        'name': '고민',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026180/a5534bb4-3831-11e7-876a-c45e9f619f7c.png'
    },

    {
        'parent_id': 1,
        'name': '다이어트',
        'background_image_url': 'https://cloud.githubusercontent.com/assets/8446067/26026164/838214ac-3831-11e7-844c-85ab92405875.png'
    },
]

class TODOsConfig(AppConfig):
    name = 'todos'


# class TopicsConfig(AppConfig):
#     name = 'topics'
#     verbose_name = "Amoeba Chatting"
#
#     def ready(self):
#         from topics.models import TopicItem
#         if not TopicItem.objects.filter(name='ROOT').exists():
#             topic_item = TopicItem.objects.create(name='ROOT')
#             for each_topic in INIT_TOPICS:
#                 topic_item = TopicItem.objects.create(
#                     name=each_topic['name'],
#                     parent_id=each_topic['parent_id'],
#                     background_image_url=each_topic['background_image_url']
#                 )
#
