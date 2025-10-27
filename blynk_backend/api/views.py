from rest_framework import status, generics, permissions, viewsets
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from django.contrib.auth.models import User

from .models import (
    UserProfile, NGOInfo, VolunteerRequest,
    DonorRequest, HelpRequest, ContactMessage, Post
)
from .serializers import (
    RegisterSerializer, LoginSerializer, UserSerializer,
    UserProfileSerializer, NGOInfoSerializer, VolunteerRequestSerializer,
    DonorRequestSerializer, HelpRequestSerializer, ContactMessageSerializer,
    PostSerializer
)

class RegisterView(APIView):
    """User registration endpoint"""
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            # Create a unique token for the new user
            token = Token.objects.create(user=user)
            
            return Response({
                'success': True,
                'message': 'User registered successfully',
                'token': token.key,
                'user': {
                    'id': user.id,
                    'username': user.username,
                    'email': user.email,
                    'first_name': user.first_name,
                    'last_name': user.last_name,
                    'role': user.profile.role
                }
            }, status=status.HTTP_201_CREATED)
        
        return Response({
            'success': False,
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    """User login endpoint"""
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            username = serializer.validated_data['username']
            password = serializer.validated_data['password']
            
            user = authenticate(username=username, password=password)
            
            if user:
                # Delete old token if it exists and create a new one for security
                Token.objects.filter(user=user).delete()
                token = Token.objects.create(user=user)
                
                return Response({
                    'success': True,
                    'message': 'Login successful',
                    'token': token.key,
                    'user': {
                        'id': user.id,
                        'username': user.username,
                        'email': user.email,
                        'first_name': user.first_name,
                        'last_name': user.last_name,
                        'role': user.profile.role if hasattr(user, 'profile') else None
                    }
                }, status=status.HTTP_200_OK)
            
            return Response({
                'success': False,
                'message': 'Invalid credentials'
            }, status=status.HTTP_401_UNAUTHORIZED)
        
        return Response({
            'success': False,
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

class LogoutView(APIView):
    """User logout endpoint"""
    permission_classes = [permissions.IsAuthenticated]
    
    def post(self, request):
        request.user.auth_token.delete()
        return Response({
            'success': True,
            'message': 'Logged out successfully'
        }, status=status.HTTP_200_OK)

class UserProfileView(APIView):
    """Get current user profile"""
    permission_classes = [permissions.IsAuthenticated]
    
    def get(self, request):
        serializer = UserProfileSerializer(request.user.profile)
        return Response({
            'success': True,
            'profile': serializer.data
        }, status=status.HTTP_200_OK)

class NGOInfoView(generics.ListAPIView):
    """Get NGO information"""
    permission_classes = [permissions.AllowAny]
    serializer_class = NGOInfoSerializer
    
    def get_queryset(self):
        return NGOInfo.objects.all()
    
    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset().first()
        if queryset:
            serializer = self.get_serializer(queryset)
            return Response({
                'success': True,
                'ngo_info': serializer.data
            }, status=status.HTTP_200_OK)
        
        return Response({
            'success': False,
            'message': 'NGO information not found'
        }, status=status.HTTP_404_NOT_FOUND)

class VolunteerRequestView(APIView):
    """Create and list volunteer requests"""
    permission_classes = [permissions.IsAuthenticated]
    
    def get(self, request):
        requests = VolunteerRequest.objects.filter(user=request.user)
        serializer = VolunteerRequestSerializer(requests, many=True)
        return Response({
            'success': True,
            'requests': serializer.data
        }, status=status.HTTP_200_OK)
    
    def post(self, request):
        serializer = VolunteerRequestSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response({
                'success': True,
                'message': 'Volunteer request submitted successfully',
                'request': serializer.data
            }, status=status.HTTP_201_CREATED)
        
        return Response({
            'success': False,
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

class DonorRequestView(APIView):
    """Create and list donor requests"""
    permission_classes = [permissions.IsAuthenticated]
    
    def get(self, request):
        requests = DonorRequest.objects.filter(user=request.user)
        serializer = DonorRequestSerializer(requests, many=True)
        return Response({
            'success': True,
            'requests': serializer.data
        }, status=status.HTTP_200_OK)
    
    def post(self, request):
        serializer = DonorRequestSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response({
                'success': True,
                'message': 'Donation request submitted successfully',
                'request': serializer.data
            }, status=status.HTTP_201_CREATED)
        
        return Response({
            'success': False,
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

class HelpRequestView(APIView):
    """Create and list help requests"""
    permission_classes = [permissions.IsAuthenticated]
    
    def get(self, request):
        requests = HelpRequest.objects.filter(user=request.user)
        serializer = HelpRequestSerializer(requests, many=True)
        return Response({
            'success': True,
            'requests': serializer.data
        }, status=status.HTTP_200_OK)
    
    def post(self, request):
        serializer = HelpRequestSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user)
            return Response({
                'success': True,
                'message': 'Help request submitted successfully',
                'request': serializer.data
            }, status=status.HTTP_201_CREATED)
        
        return Response({
            'success': False,
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

class ContactMessageView(APIView):
    """Submit contact messages"""
    permission_classes = [permissions.AllowAny]
    
    def post(self, request):
        serializer = ContactMessageSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({
                'success': True,
                'message': 'Message sent successfully'
            }, status=status.HTTP_201_CREATED)
        
        return Response({
            'success': False,
            'errors': serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)

class PostViewSet(viewsets.ModelViewSet):
    """ViewSet for creating and managing posts"""
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    
    def get_queryset(self):
        return Post.objects.all().order_by('-created_at')
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class ApprovedPostViewSet(viewsets.ReadOnlyModelViewSet):
    """Read-only viewset for approved posts (for map)"""
    serializer_class = PostSerializer
    permission_classes = [permissions.AllowAny]
    
    def get_queryset(self):
        return Post.objects.filter(is_confirmed=True).order_by('-created_at')
