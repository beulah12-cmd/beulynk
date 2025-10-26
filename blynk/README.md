# BEULYNK - Unity through connection 💙

A modern, beautiful humanitarian platform connecting people in need with donors and helpers, built for **Beulah Humanity Reconciliation**.

## 🎨 Features

### ✨ Landing Page
- **Hero Section** with animated slogan and inspiring design
- **About Section** showcasing NGO mission and impact statistics
- **How It Works** step-by-step guide for users
- **Testimonials** featuring success stories
- **Call-to-Action** with prominent Sign In/Sign Up buttons
- **Responsive Design** optimized for mobile, tablet, and web
- **Modern Animations** using Flutter Animate and Animated Text Kit

### 🔐 Authentication
- Beautiful Sign In page
- Comprehensive Sign Up page with user type selection (Donor/Recipient/Volunteer)
- Form validation
- Password visibility toggle
- Backend integration ready

### 🌐 Backend Integration
- API service configured for Django REST Framework
- Configurable endpoints for different environments
- Error handling and loading states

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / Xcode / VS Code
- Django backend running (see backend setup below)

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd BLYNK_PROJECT/blynk
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure backend URL**
   
   Edit `lib/config/api_config.dart` and update the `baseUrl`:
   
   - **For Android emulator**: `http://10.0.2.2:8000/api`
   - **For iOS simulator**: `http://localhost:8000/api`
   - **For physical device**: `http://YOUR_COMPUTER_IP:8000/api` (e.g., `http://192.168.1.100:8000/api`)
   - **For web**: `http://localhost:8000/api`

4. **Run the app**
   ```bash
   flutter run
   ```

## 🎨 Color Scheme

The app uses a modern dark theme with accent colors:

- **Primary**: `#E94560` (Vibrant Pink/Red)
- **Dark Background**: `#1A1A2E`, `#16213E`, `#0F3460`
- **Text**: White with varying opacity for hierarchy

## 📁 Project Structure

```
blynk/
├── lib/
│   ├── config/
│   │   └── api_config.dart          # API configuration
│   ├── screens/
│   │   ├── landing_page.dart        # Main landing page
│   │   ├── signin_page.dart         # Sign in screen
│   │   └── signup_page.dart         # Sign up screen
│   ├── services/
│   │   └── api_service.dart         # Django API integration
│   └── main.dart                    # App entry point
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

## 📦 Dependencies

- **google_fonts** - Modern typography with Poppins font
- **animated_text_kit** - Text animations for hero section
- **flutter_animate** - Smooth UI animations
- **http** - HTTP client for API calls
- **flutter_screenutil** - Responsive design utilities
- **font_awesome_flutter** - Icon library

## 🔧 Backend Setup

### Django Backend

The app expects a Django REST Framework backend at `/blynk_backend`.

**Required API Endpoints:**

1. **Authentication**
   - `POST /api/auth/login/` - User login
   - `POST /api/auth/register/` - User registration

2. **NGO Information**
   - `GET /api/ngo-info/` - Fetch NGO details

**Request/Response Format:**

**Login:**
```json
POST /api/auth/login/
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Register:**
```json
POST /api/auth/register/
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "user_type": "donor"  // or "recipient" or "volunteer"
}
```

### Running Django Backend

```bash
cd blynk_backend
python manage.py runserver
```

The backend will be available at `http://localhost:8000`.

## 📱 Responsive Design

The app automatically adapts to different screen sizes:

- **Mobile** (< 600px): Single column layout
- **Tablet** (600px - 900px): Optimized card layouts
- **Desktop/Web** (> 900px): Multi-column layouts with enhanced spacing

## 🎯 User Types

The app supports three user types:

1. **Donor** 💝 - People who want to give or donate
2. **Recipient** 🙏 - People who need support
3. **Volunteer** 🤝 - People who want to help through service

## 🛠️ Customization

### Changing Colors

Edit the theme in `lib/main.dart`:

```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFFE94560),  // Change this
  brightness: Brightness.dark,
),
```

### Modifying API Base URL

Edit `lib/config/api_config.dart`:

```dart
static const String baseUrl = 'http://your-backend-url/api';
```

### Updating Content

Landing page content can be modified in `lib/screens/landing_page.dart`:
- Hero slogan
- About section text
- Statistics
- Testimonials

## 🧪 Testing

Run tests with:

```bash
flutter test
```

## 🌐 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📝 Notes

- The app currently uses placeholder social login buttons (Google). Implement actual OAuth if needed.
- Backend endpoints are configured but require actual Django implementation.
- Consider adding error boundary widgets for production.
- Add analytics and crash reporting for production use.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is part of Beulah Humanity Reconciliation's humanitarian initiatives.

## 💙 About Beulah Humanity Reconciliation

BLYNK is a platform dedicated to bridging the gap between compassion and action. We believe that every person deserves dignity, hope, and support.

---

**Made with ❤️ for humanity**
