from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    """Extended user profile for BEULYNK users"""
    ROLE_CHOICES = [
        ('volunteer', 'Volunteer'),
        ('donor', 'Donor'),
        ('help_seeker', 'Help Seeker'),
    ]
    
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    role = models.CharField(max_length=20, choices=ROLE_CHOICES)
    phone = models.CharField(max_length=20, blank=True, null=True)
    address = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"{self.user.username} - {self.role}"

class NGOInfo(models.Model):
    """BEULYNK organization information"""
    name = models.CharField(max_length=200, default="BEULYNK")
    full_name = models.CharField(max_length=200, default="Beulah Humanity Reconciliation")
    tagline = models.CharField(max_length=500, default="Unity through connection")
    mission = models.TextField()
    description = models.TextField()
    email = models.EmailField()
    phone = models.CharField(max_length=20)
    address = models.TextField()
    facebook_url = models.URLField(blank=True, null=True)
    twitter_url = models.URLField(blank=True, null=True)
    instagram_url = models.URLField(blank=True, null=True)
    linkedin_url = models.URLField(blank=True, null=True)
    
    # Statistics
    lives_impacted = models.IntegerField(default=10000)
    active_donors = models.IntegerField(default=500)
    communities_served = models.IntegerField(default=50)
    
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        verbose_name = "NGO Information"
        verbose_name_plural = "NGO Information"
    
    def __str__(self):
        return self.name

class VolunteerRequest(models.Model):
    """Volunteer registration requests"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='volunteer_requests')
    skills = models.TextField(help_text="Skills and expertise")
    availability = models.CharField(max_length=200, help_text="Available days/hours")
    motivation = models.TextField(help_text="Why do you want to volunteer?")
    status = models.CharField(
        max_length=20,
        choices=[
            ('pending', 'Pending'),
            ('approved', 'Approved'),
            ('rejected', 'Rejected'),
        ],
        default='pending'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"Volunteer Request - {self.user.username}"

class DonorRequest(models.Model):
    """Donor registration and donation tracking"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='donor_requests')
    donation_type = models.CharField(
        max_length=50,
        choices=[
            ('one_time', 'One Time'),
            ('monthly', 'Monthly'),
            ('yearly', 'Yearly'),
        ]
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    message = models.TextField(blank=True, null=True)
    status = models.CharField(
        max_length=20,
        choices=[
            ('pending', 'Pending'),
            ('completed', 'Completed'),
            ('failed', 'Failed'),
        ],
        default='pending'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"Donor Request - {self.user.username}"

class HelpRequest(models.Model):
    """Help requests from people in need"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='help_requests')
    category = models.CharField(
        max_length=50,
        choices=[
            ('financial', 'Financial Assistance'),
            ('medical', 'Medical Help'),
            ('education', 'Educational Support'),
            ('food', 'Food Assistance'),
            ('shelter', 'Shelter'),
            ('other', 'Other'),
        ]
    )
    title = models.CharField(max_length=200)
    description = models.TextField()
    urgency = models.CharField(
        max_length=20,
        choices=[
            ('low', 'Low'),
            ('medium', 'Medium'),
            ('high', 'High'),
            ('critical', 'Critical'),
        ],
        default='medium'
    )
    status = models.CharField(
        max_length=20,
        choices=[
            ('open', 'Open'),
            ('in_progress', 'In Progress'),
            ('fulfilled', 'Fulfilled'),
            ('closed', 'Closed'),
        ],
        default='open'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"Help Request - {self.title}"

class ContactMessage(models.Model):
    """Contact form submissions"""
    name = models.CharField(max_length=200)
    email = models.EmailField()
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"Message from {self.name}"

class Post(models.Model):
    """User-submitted problem posts with media and location"""
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='posts')
    title = models.CharField(max_length=200)
    description = models.TextField()
    photo = models.ImageField(upload_to='posts/', blank=True, null=True)
    video = models.FileField(upload_to='posts/videos/', blank=True, null=True)
    latitude = models.FloatField(blank=True, null=True)
    longitude = models.FloatField(blank=True, null=True)
    is_confirmed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        ordering = ['-created_at']
    
    def __str__(self):
        return f"{self.title} - {self.user.username}"
