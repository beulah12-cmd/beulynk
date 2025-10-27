"""
URL configuration for blynk_backend project.
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('api.urls')),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

# Customize admin site
admin.site.site_header = "BEULYNK Administration"
admin.site.site_title = "BEULYNK Admin Portal"
admin.site.index_title = "Welcome to BEULYNK Administration"
