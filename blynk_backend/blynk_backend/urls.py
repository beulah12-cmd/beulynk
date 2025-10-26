"""
URL configuration for blynk_backend project.
"""
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
]

# Customize admin site
admin.site.site_header = "BEULYNK Administration"
admin.site.site_title = "BEULYNK Admin Portal"
admin.site.index_title = "Welcome to BEULYNK Administration"
