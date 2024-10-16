from django.urls import path
from .views import list_bucket_content

urlpatterns = [
    path('list-bucket-content/', list_bucket_content),
    path('list-bucket-content/<path:path>/', list_bucket_content),
]
