# BEULYNK Setup Guide

## ✅ What's Been Created

### Flutter Frontend (`blynk/`)

**Screens:**
- ✨ **Landing Page** - Modern, animated landing page with:
  - Hero section with animated slogan
  - About Beulah Humanity Reconciliation
  - How It Works section (3-step process)
  - Testimonials
  - Call-to-Action section
  - Responsive design (mobile, tablet, web)
  
- 🔐 **Sign In Page** - Beautiful authentication with:
  - Email/password login
  - Form validation
  - Loading states
  - Social login placeholder (Google)
  
- 📝 **Sign Up Page** - Comprehensive registration with:
  - User type selection (Donor/Recipient/Volunteer)
  - Full form validation
  - Password confirmation
  - Beautiful animations

**Services:**
- 🌐 **API Service** - Django backend integration with:
  - GET/POST helpers
  - Error handling
  - Login/Register endpoints
  
**Configuration:**
- ⚙️ **API Config** - Centralized backend URL configuration

### Design Features

**Color Palette:**
- Primary: `#E94560` (Vibrant Pink/Red)
- Dark Backgrounds: `#1A1A2E`, `#16213E`, `#0F3460`
- Clean, modern gradient design

**Typography:**
- Poppins font family (Google Fonts)
- Clear hierarchy and spacing

**Animations:**
- Fade in/out effects
- Slide transitions
- Scale animations
- Typewriter text effect
- Shimmer effects

## 🚀 Quick Start

### 1. Install Dependencies

```bash
cd blynk
flutter pub get
```

### 2. Configure Backend URL

Edit `lib/config/api_config.dart`:

```dart
// For Android emulator
static const String baseUrl = 'http://10.0.2.2:8000/api';

// For iOS simulator
static const String baseUrl = 'http://localhost:8000/api';

// For physical device (replace with your computer's IP)
static const String baseUrl = 'http://192.168.1.100:8000/api';
```

### 3. Run the App

```bash
flutter run
```

**Platform Selection:**
- Press `1` for Android
- Press `2` for iOS
- Press `3` for Web
- Press `4` for Windows
- Press `5` for macOS
- Press `6` for Linux

## 🔧 Backend Setup (Django)

### Option 1: Django (As Requested)

1. **Install dependencies:**
   ```bash
   cd blynk_backend
   pip install -r requirements.txt
   ```

2. **Run migrations:**
   ```bash
   python manage.py migrate
   ```

3. **Start server:**
   ```bash
   python manage.py runserver
   ```

4. **Create API endpoints** (you'll need to implement these in Django)

### Option 2: Firebase (Recommended per Memory)

**Note:** Your project memory indicates you're using Firebase instead of Django [[memory:7834563]].

To switch to Firebase:

1. **Add Firebase to Flutter:**
   ```bash
   flutter pub add firebase_core firebase_auth cloud_firestore
   ```

2. **Setup Firebase:**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Add Android/iOS/Web apps
   - Download config files
   - Follow Firebase setup instructions

3. **Replace API Service** with Firebase services

Would you like help switching to Firebase?

## 📱 Testing

Run on different platforms:

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

## 🎨 Customization

### Change Colors

Edit `lib/main.dart`:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFFE94560), // Your color here
  brightness: Brightness.dark,
),
```

### Modify Landing Page Content

Edit `lib/screens/landing_page.dart`:
- Line 179: Hero slogan text
- Line 266: About section content
- Line 318: Statistics
- Line 430: Testimonials

### Update API Endpoints

Edit `lib/services/api_service.dart` to add new endpoints.

## 📋 Required Django API Endpoints

The Flutter app expects these endpoints:

```
POST /api/auth/login/
{
  "email": "user@example.com",
  "password": "password123"
}

POST /api/auth/register/
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "user_type": "donor"  // or "recipient" or "volunteer"
}

GET /api/ngo-info/
```

## 🐛 Troubleshooting

### "Connection refused" error
- Make sure Django server is running
- Check the API URL in `api_config.dart`
- For Android emulator, use `10.0.2.2` instead of `localhost`

### Font not loading
- Run `flutter pub get` again
- Clear build cache: `flutter clean && flutter pub get`

### Hot reload not working
- Try hot restart: Press `R` in terminal (or `Shift+R` in IDE)

## 📦 Dependencies Used

- `google_fonts` - Typography
- `animated_text_kit` - Text animations
- `flutter_animate` - UI animations
- `http` - API calls
- `flutter_screenutil` - Responsive design
- `font_awesome_flutter` - Icons

## 🎯 Next Steps

1. **Implement Django backend** or switch to Firebase
2. **Add user authentication** state management
3. **Create home dashboard** after login
4. **Build core features** (donations, requests, volunteering)
5. **Add profile management**
6. **Implement notifications**

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Django REST Framework](https://www.django-rest-framework.org/)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Material Design 3](https://m3.material.io/)

---

**Need Help?** Check the main README.md for more detailed information.

