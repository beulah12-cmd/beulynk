from rest_framework import serializers
from django.contrib.auth.models import User
from .models import (
    UserProfile, NGOInfo, VolunteerRequest,
    DonorRequest, HelpRequest, ContactMessage
)

class UserSerializer(serializers.ModelSerializer):
    """Serializer for User model"""
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']
        read_only_fields = ['id']

class UserProfileSerializer(serializers.ModelSerializer):
    """Serializer for UserProfile model"""
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = UserProfile
        fields = ['id', 'user', 'role', 'phone', 'address', 'created_at', 'updated_at']
        read_only_fields = ['id', 'created_at', 'updated_at']

class RegisterSerializer(serializers.ModelSerializer):
    """Serializer for user registration"""
    password = serializers.CharField(write_only=True, min_length=6)
    confirm_password = serializers.CharField(write_only=True)
    role = serializers.ChoiceField(choices=UserProfile.ROLE_CHOICES)
    
    class Meta:
        model = User
        fields = ['username', 'email', 'password', 'confirm_password', 'first_name', 'last_name', 'role']
    
    def validate(self, data):
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError({"password": "Passwords do not match"})
        return data
    
    def create(self, validated_data):
        # Remove confirm_password and role from validated_data
        validated_data.pop('confirm_password')
        role = validated_data.pop('role')
        
        # Create user
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
            first_name=validated_data.get('first_name', ''),
            last_name=validated_data.get('last_name', '')
        )
        
        # Create user profile
        UserProfile.objects.create(user=user, role=role)
        
        return user

class LoginSerializer(serializers.Serializer):
    """Serializer for user login"""
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

class NGOInfoSerializer(serializers.ModelSerializer):
    """Serializer for NGO information"""
    class Meta:
        model = NGOInfo
        fields = [
            'id', 'name', 'full_name', 'tagline', 'mission', 'description',
            'email', 'phone', 'address', 'facebook_url', 'twitter_url',
            'instagram_url', 'linkedin_url', 'lives_impacted',
            'active_donors', 'communities_served', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']

class VolunteerRequestSerializer(serializers.ModelSerializer):
    """Serializer for volunteer requests"""
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = VolunteerRequest
        fields = ['id', 'user', 'skills', 'availability', 'motivation', 'status', 'created_at', 'updated_at']
        read_only_fields = ['id', 'user', 'status', 'created_at', 'updated_at']

class DonorRequestSerializer(serializers.ModelSerializer):
    """Serializer for donor requests"""
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = DonorRequest
        fields = ['id', 'user', 'donation_type', 'amount', 'message', 'status', 'created_at', 'updated_at']
        read_only_fields = ['id', 'user', 'status', 'created_at', 'updated_at']

class HelpRequestSerializer(serializers.ModelSerializer):
    """Serializer for help requests"""
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = HelpRequest
        fields = [
            'id', 'user', 'category', 'title', 'description',
            'urgency', 'status', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'user', 'status', 'created_at', 'updated_at']

class ContactMessageSerializer(serializers.ModelSerializer):
    """Serializer for contact messages"""
    class Meta:
        model = ContactMessage
        fields = ['id', 'name', 'email', 'message', 'is_read', 'created_at']
        read_only_fields = ['id', 'is_read', 'created_at']

