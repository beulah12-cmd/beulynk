from django.urls import path
from .views import (
    RegisterView, LoginView, LogoutView, UserProfileView,
    NGOInfoView, VolunteerRequestView, DonorRequestView,
    HelpRequestView, ContactMessageView
)

app_name = 'api'

urlpatterns = [
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
]

