# BEULYNK Backend Integration Guide

## 🎯 Overview

This document explains how the BEULYNK Flutter frontend connects to the Django REST API backend.

## 📡 Backend API Endpoints

### Base URL
- **Development (Chrome/Web)**: `http://localhost:8000`
- **Development (Android Emulator)**: `http://10.0.2.2:8000`
- **Development (Physical Device)**: `http://YOUR_IP:8000`

### Authentication Endpoints

#### 1. Register User
```
POST /api/auth/register/
```

**Request Body:**
```json
{
  "username": "string",
  "email": "string",
  "password": "string",
  "confirm_password": "string",
  "first_name": "string",
  "last_name": "string",
  "role": "volunteer" | "donor" | "help_seeker"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "token": "auth_token_here",
  "user": {
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "role": "volunteer"
  }
}
```

#### 2. Login User
```
POST /api/auth/login/
```

**Request Body:**
```json
{
  "username": "string",
  "password": "string"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "token": "auth_token_here",
  "user": {
    "id": 1,
    "username": "john_doe",
    "email": "john@example.com",
    "role": "volunteer"
  }
}
```

#### 3. Logout User
```
POST /api/auth/logout/
Headers: Authorization: Token <token>
```

**Response:**
```json
{
  "success": true,
  "message": "Logged out successfully"
}
```

### NGO Information

#### Get NGO Info
```
GET /api/ngo-info/
```

**Response:**
```json
{
  "success": true,
  "ngo_info": {
    "id": 1,
    "name": "BEULYNK",
    "full_name": "Beulah Humanity Reconciliation",
    "tagline": "Unity through connection",
    "mission": "...",
    "description": "...",
    "email": "contact@beulynk.org",
    "phone": "+1 (555) 123-4567",
    "address": "...",
    "lives_impacted": 10000,
    "active_donors": 500,
    "communities_served": 50
  }
}
```

### Volunteer Requests

#### Submit Volunteer Request
```
POST /api/volunteer/
Headers: Authorization: Token <token>
```

**Request Body:**
```json
{
  "skills": "string",
  "availability": "string",
  "motivation": "string"
}
```

### Donor Requests

#### Submit Donation
```
POST /api/donor/
Headers: Authorization: Token <token>
```

**Request Body:**
```json
{
  "donation_type": "one_time" | "monthly" | "yearly",
  "amount": "100.00",
  "message": "optional message"
}
```

### Help Requests

#### Submit Help Request
```
POST /api/help-request/
Headers: Authorization: Token <token>
```

**Request Body:**
```json
{
  "category": "financial" | "medical" | "education" | "food" | "shelter" | "other",
  "title": "string",
  "description": "string",
  "urgency": "low" | "medium" | "high" | "critical"
}
```

### Contact

#### Submit Contact Message
```
POST /api/contact/
```

**Request Body:**
```json
{
  "name": "string",
  "email": "string",
  "message": "string"
}
```

## 🔐 Authentication Flow

### 1. Registration
```dart
final response = await ApiService.register(
  username: 'john_doe',
  email: 'john@example.com',
  password: 'password123',
  confirmPassword: 'password123',
  firstName: 'John',
  lastName: 'Doe',
  role: 'volunteer', // or 'donor' or 'help_seeker'
);

if (response.success) {
  // Token and user data automatically saved
  // Navigate to home
}
```

### 2. Login
```dart
final response = await ApiService.login(
  username: 'john_doe',
  password: 'password123',
);

if (response.success) {
  // Token and user data automatically saved
  // Navigate to home
}
```

### 3. Logout
```dart
await ApiService.logout();
// Token cleared from local storage
```

### 4. Check Authentication Status
```dart
final isAuth = await AuthService.isAuthenticated();
if (isAuth) {
  // User is logged in
}
```

## 📦 Data Models

### User Model
```dart
class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? role;
}
```

### NGO Info Model
```dart
class NGOInfo {
  final int id;
  final String name;
  final String fullName;
  final String tagline;
  final String mission;
  final String description;
  final String email;
  final String phone;
  final String address;
  final int livesImpacted;
  final int activeDonors;
  final int communitiesServed;
}
```

## 🚀 Running the Backend

### 1. Start Django Server
```bash
cd blynk_backend
python manage.py runserver
```

The server will start at `http://localhost:8000`

### 2. Access Admin Panel
```
URL: http://localhost:8000/admin
```

Create a superuser first:
```bash
python manage.py createsuperuser
```

### 3. Test API Endpoints
You can test endpoints using:
- Browser: `http://localhost:8000/api/ngo-info/`
- Postman
- curl commands

## 🔧 Configuration

### For Android Emulator
In `lib/config/api_config.dart`:
```dart
static const String _androidEmulatorUrl = 'http://10.0.2.2:8000';
```

### For Physical Android Device
1. Find your computer's IP address:
   - Windows: `ipconfig`
   - Mac/Linux: `ifconfig`

2. Update `api_config.dart`:
```dart
return 'http://YOUR_IP_ADDRESS:8000';
```

3. Ensure your device is on the same network as your computer.

### For Chrome/Web
```dart
return 'http://localhost:8000';
```

## 🔒 Security Notes

### Development
- CORS is set to allow all origins
- Debug mode is enabled
- Secret key is exposed

### Production Checklist
- [ ] Change `SECRET_KEY` in settings.py
- [ ] Set `DEBUG = False`
- [ ] Configure specific `CORS_ALLOWED_ORIGINS`
- [ ] Use HTTPS
- [ ] Set up proper database (PostgreSQL)
- [ ] Configure static files serving
- [ ] Set up environment variables
- [ ] Enable CSRF protection

## 🧪 Testing

### Test Registration
```bash
curl -X POST http://localhost:8000/api/auth/register/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "testpass123",
    "confirm_password": "testpass123",
    "first_name": "Test",
    "last_name": "User",
    "role": "volunteer"
  }'
```

### Test Login
```bash
curl -X POST http://localhost:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "testpass123"
  }'
```

### Test NGO Info
```bash
curl http://localhost:8000/api/ngo-info/
```

## 📱 Flutter Integration Examples

### Sign Up Page
```dart
final response = await ApiService.register(
  username: _usernameController.text,
  email: _emailController.text,
  password: _passwordController.text,
  confirmPassword: _confirmPasswordController.text,
  firstName: _nameController.text.split(' ').first,
  lastName: _nameController.text.split(' ').last,
  role: _selectedRole == UserRole.volunteer ? 'volunteer' :
        _selectedRole == UserRole.donor ? 'donor' : 'help_seeker',
);

if (response.success) {
  // Show success message
  // Navigate to home
} else {
  // Show error message
}
```

### Sign In Page
```dart
final response = await ApiService.login(
  username: _emailController.text,
  password: _passwordController.text,
);

if (response.success) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LandingPage()),
    (route) => false,
  );
}
```

### Fetch NGO Info
```dart
final ngoInfo = await ApiService.getNGOInfo();
if (ngoInfo != null) {
  setState(() {
    _ngoInfo = ngoInfo;
  });
}
```

### Submit Contact Message
```dart
final response = await ApiService.submitContactMessage(
  name: _nameController.text,
  email: _emailController.text,
  message: _messageController.text,
);

if (response['success'] == true) {
  // Show success message
}
```

## 🐛 Troubleshooting

### Connection Refused
- Ensure Django server is running
- Check the correct URL in `api_config.dart`
- For Android emulator, use `10.0.2.2` instead of `localhost`

### CORS Errors
- Verify `django-cors-headers` is installed
- Check `CORS_ALLOW_ALL_ORIGINS = True` in settings.py

### Authentication Errors
- Ensure token is being sent in headers
- Check token format: `Token <token_value>`
- Verify user is logged in before making authenticated requests

### Network Errors on Physical Device
- Ensure device and computer are on same network
- Check firewall settings
- Use computer's IP address, not localhost

## 📚 Additional Resources

- Django REST Framework: https://www.django-rest-framework.org/
- Flutter HTTP Package: https://pub.dev/packages/http
- Shared Preferences: https://pub.dev/packages/shared_preferences

## ✅ Integration Checklist

- [x] Django backend with REST API endpoints
- [x] CORS configuration
- [x] Token authentication
- [x] Flutter data models
- [x] API service with all endpoints
- [x] Authentication service with token storage
- [x] Sign up integration with role selection
- [x] Sign in integration
- [x] NGO info fetching
- [ ] Contact form integration
- [ ] Volunteer/Donor/Help request forms
- [ ] Error handling and loading states
- [ ] Testing on Android and Chrome


