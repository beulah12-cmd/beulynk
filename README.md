# BEULYNK - Full-Stack Humanitarian Platform

A modern, responsive Flutter application with Django REST API backend for "Beulah Humanity Reconciliation" NGO.

## 🎯 Project Overview

BEULYNK connects donors, volunteers, and people in need through a beautiful, unified interface that works seamlessly across Android, iOS, and Web platforms.

## 📁 Project Structure

```
BLYNK_PROJECT/
├── blynk_backend/           # Django REST API Backend
│   ├── api/                 # API app with models, views, serializers
│   ├── blynk_backend/       # Django project settings
│   ├── db.sqlite3          # SQLite database
│   ├── manage.py           # Django management script
│   └── requirements.txt    # Python dependencies
│
├── blynk/                   # Flutter Frontend
│   ├── lib/
│   │   ├── config/         # API configuration
│   │   ├── models/         # Data models
│   │   ├── screens/        # UI screens
│   │   ├── services/       # API & auth services
│   │   └── widgets/        # Reusable components
│   ├── assets/             # Images and static files
│   └── pubspec.yaml        # Flutter dependencies
│
└── README.md               # This file
```

## 🚀 Quick Start

### Backend Setup (Django)

1. **Navigate to backend directory:**
   ```bash
   cd blynk_backend
   ```

2. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Create migrations:**
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

4. **Initialize NGO data:**
   ```bash
   python manage.py init_ngo_data
   ```

5. **Create superuser (optional):**
   ```bash
   python manage.py createsuperuser
   ```

6. **Run development server:**
   ```bash
   python manage.py runserver
   ```

   Backend runs at: `http://localhost:8000`

### Frontend Setup (Flutter)

1. **Navigate to Flutter directory:**
   ```bash
   cd blynk
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   # For Chrome/Web
   flutter run -d chrome

   # For Android
   flutter run -d <device-id>
   ```

## 🎨 Features

### Frontend Features
- ✅ Modern, responsive UI design
- ✅ Role-based authentication (Volunteer/Donor/Help Seeker)
- ✅ Beautiful hero sections on all screens
- ✅ Smooth animations and transitions
- ✅ Reusable component library
- ✅ Cross-platform (Android, iOS, Web)
- ✅ Token-based authentication

### Backend Features
- ✅ Django REST Framework API
- ✅ Token-based authentication
- ✅ User profiles with roles
- ✅ NGO information management
- ✅ Volunteer request system
- ✅ Donor registration
- ✅ Help request tracking
- ✅ Contact message handling
- ✅ CORS enabled for Flutter access
- ✅ Admin panel

## 📡 API Endpoints

### Authentication
- `POST /api/auth/register/` - Register new user
- `POST /api/auth/login/` - Login user
- `POST /api/auth/logout/` - Logout user

### NGO Information
- `GET /api/ngo-info/` - Get organization details

### Requests
- `POST /api/volunteer/` - Submit volunteer request
- `POST /api/donor/` - Submit donation
- `POST /api/help-request/` - Request help
- `POST /api/contact/` - Send contact message

## 🔐 Environment Configuration

### For Development
- Backend: `http://localhost:8000`
- Frontend (Web): `http://localhost:PORT`

### For Android Emulator
- Backend: `http://10.0.2.2:8000`
- Update in `lib/config/api_config.dart`

### For Physical Device
- Backend: `http://YOUR_IP:8000`
- Update in `lib/config/api_config.dart`

## 📚 Documentation

- [Backend Integration Guide](blynk/BACKEND_INTEGRATION.md)
- [Design System](blynk/DESIGN_SYSTEM.md)
- [Implementation Guide](blynk/README_DESIGN.md)

## 🛠️ Technology Stack

### Backend
- Django 5.2.5
- Django REST Framework 3.14+
- Python 3.8+
- SQLite (development)
- Token Authentication
- CORS headers

### Frontend
- Flutter 3.8+
- Dart
- Provider/Riverpod (optional)
- HTTP for API calls
- Shared Preferences for token storage
- Google Fonts
- flutter_screenutil for responsiveness
- flutter_animate for animations

## 🌐 Deployment

### Deploy Django Backend to Render
1. Push code to GitHub
2. Create new Web Service on Render
3. Connect GitHub repository
4. Use Python buildpack
5. Add environment variables if needed
6. Deploy!

### Deploy Flutter Web to Render
1. Build Flutter web app
2. Create Static Site on Render
3. Upload build/web folder
4. Configure custom domain

## 📝 License

This project is for "Beulah Humanity Reconciliation" NGO.

## 👥 Contributors

- Built with ❤️ for humanitarian work

## 📞 Support

For issues or questions, please refer to the documentation files in the project.

