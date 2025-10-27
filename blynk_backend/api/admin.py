from django.contrib import admin
from .models import (
    UserProfile, NGOInfo, VolunteerRequest,
    DonorRequest, HelpRequest, ContactMessage, Post
)

@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'role', 'phone', 'address', 'created_at']

@admin.register(NGOInfo)
class NGOInfoAdmin(admin.ModelAdmin):
    list_display = ['name', 'email', 'phone', 'lives_impacted', 'active_donors']

@admin.register(VolunteerRequest)
class VolunteerRequestAdmin(admin.ModelAdmin):
    list_display = ['user', 'skills', 'status', 'created_at']

@admin.register(DonorRequest)
class DonorRequestAdmin(admin.ModelAdmin):
    list_display = ['user', 'donation_type', 'amount', 'status', 'created_at']

@admin.register(HelpRequest)
class HelpRequestAdmin(admin.ModelAdmin):
    list_display = ['user', 'title', 'category', 'urgency', 'status', 'created_at']

@admin.register(ContactMessage)
class ContactMessageAdmin(admin.ModelAdmin):
    list_display = ['name', 'email', 'is_read', 'created_at']

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'user', 'is_confirmed', 'created_at']
    list_filter = ['is_confirmed', 'created_at']
    search_fields = ['title', 'description', 'user__username']
    actions = ['approve_posts', 'unapprove_posts']
    
    def approve_posts(self, request, queryset):
        queryset.update(is_confirmed=True)
        self.message_user(request, f"{queryset.count()} posts approved")
    approve_posts.short_description = "Approve selected posts"
    
    def unapprove_posts(self, request, queryset):
        queryset.update(is_confirmed=False)
        self.message_user(request, f"{queryset.count()} posts unapproved")
    unapprove_posts.short_description = "Unapprove selected posts"
