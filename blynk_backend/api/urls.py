from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .views import (
    RegisterView, LoginView, LogoutView, UserProfileView,
    NGOInfoView, VolunteerRequestView, DonorRequestView,
    HelpRequestView, ContactMessageView, PostViewSet, ApprovedPostViewSet
)

# API root view
@api_view(['GET'])
def api_root(request):
    return Response({
        'auth': {
            'register': '/api/auth/register/',
            'login': '/api/auth/login/',
            'logout': '/api/auth/logout/',
            'profile': '/api/auth/profile/',
        },
        'posts': {
            'list': '/api/posts/',
            'create': '/api/posts/',
            'approved': '/api/posts/approved/',
        },
        'ngo-info': '/api/ngo-info/',
        'volunteer': '/api/volunteer/',
        'donor': '/api/donor/',
        'help-request': '/api/help-request/',
        'contact': '/api/contact/',
    })

# Router for ViewSets
router = DefaultRouter()
router.register(r'posts', PostViewSet, basename='posts')
router.register(r'approved-posts', ApprovedPostViewSet, basename='approved-posts')

app_name = 'api'

urlpatterns = [
    # API root
    path('', api_root, name='api-root'),
    
    # Authentication endpoints
    path('auth/register/', RegisterView.as_view(), name='register'),
    path('auth/login/', LoginView.as_view(), name='login'),
    path('auth/logout/', LogoutView.as_view(), name='logout'),
    path('auth/profile/', UserProfileView.as_view(), name='profile'),
    
    # NGO information
    path('ngo-info/', NGOInfoView.as_view(), name='ngo-info'),
    
    # Volunteer, Donor, and Help Request endpoints
    path('volunteer/', VolunteerRequestView.as_view(), name='volunteer'),
    path('donor/', DonorRequestView.as_view(), name='donor'),
    path('help-request/', HelpRequestView.as_view(), name='help-request'),
    
    # Contact
    path('contact/', ContactMessageView.as_view(), name='contact'),
    
    # Include router URLs
    path('', include(router.urls)),
]
