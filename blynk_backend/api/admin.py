from django.contrib import admin
from .models import (
    UserProfile, NGOInfo, VolunteerRequest,
    DonorRequest, HelpRequest, ContactMessage
)

@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'role', 'phone', 'created_at']
    list_filter = ['role', 'created_at']
    search_fields = ['user__username', 'user__email', 'phone']
    readonly_fields = ['created_at', 'updated_at']

@admin.register(NGOInfo)
class NGOInfoAdmin(admin.ModelAdmin):
    list_display = ['name', 'full_name', 'email', 'phone']
    readonly_fields = ['created_at', 'updated_at']

@admin.register(VolunteerRequest)
class VolunteerRequestAdmin(admin.ModelAdmin):
    list_display = ['user', 'status', 'created_at']
    list_filter = ['status', 'created_at']
    search_fields = ['user__username', 'skills']
    readonly_fields = ['created_at', 'updated_at']

@admin.register(DonorRequest)
class DonorRequestAdmin(admin.ModelAdmin):
    list_display = ['user', 'donation_type', 'amount', 'status', 'created_at']
    list_filter = ['donation_type', 'status', 'created_at']
    search_fields = ['user__username']
    readonly_fields = ['created_at', 'updated_at']

@admin.register(HelpRequest)
class HelpRequestAdmin(admin.ModelAdmin):
    list_display = ['user', 'title', 'category', 'urgency', 'status', 'created_at']
    list_filter = ['category', 'urgency', 'status', 'created_at']
    search_fields = ['user__username', 'title', 'description']
    readonly_fields = ['created_at', 'updated_at']

@admin.register(ContactMessage)
class ContactMessageAdmin(admin.ModelAdmin):
    list_display = ['name', 'email', 'is_read', 'created_at']
    list_filter = ['is_read', 'created_at']
    search_fields = ['name', 'email', 'message']
    readonly_fields = ['created_at']
