from django.views.generic.base import TemplateView

class ChatView(TemplateView):
    template_name: str = "chat/chat.html"
