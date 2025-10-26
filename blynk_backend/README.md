# BEULYNK Backend - Django REST API

Django REST Framework backend for the BEULYNK humanitarian platform.

## 🚀 Quick Start

### Prerequisites
- Python 3.10 or higher
- pip (Python package manager)
- Virtual environment (recommended)

### Installation

1. **Navigate to backend directory**
   ```bash
   cd blynk_backend
   ```

2. **Create and activate virtual environment**
   
   **Windows:**
   ```bash
   python -m venv venv
   venv\Scripts\activate
   ```
   
   **Mac/Linux:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```

3. **Install dependencies**
   ```bash
   pip install django djangorestframework django-cors-headers
   ```

4. **Run migrations**
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

5. **Create superuser (admin)**
   ```bash
   python manage.py createsuperuser
   ```

6. **Run the development server**
   ```bash
   python manage.py runserver
   ```

The server will start at `http://localhost:8000`.

## 📋 Required API Endpoints

The Flutter app expects the following endpoints:

### Authentication
- `POST /api/auth/login/` - User login
- `POST /api/auth/register/` - User registration

### NGO Information
- `GET /api/ngo-info/` - Fetch NGO details

## 🔧 Next Steps

1. Create a Django app for API endpoints:
   ```bash
   python manage.py startapp api
   ```

2. Add `api` and `rest_framework` to `INSTALLED_APPS` in `settings.py`

3. Configure CORS to allow Flutter app connections

4. Implement the required models and views

5. Create serializers for data validation

## 📝 Note

**Alternative:** This project memory indicates Firebase is being used instead of Django [[memory:7834563]]. 
If you prefer Firebase, you can:
- Replace Django backend with Firebase services
- Update Flutter app to use Firebase packages (firebase_auth, cloud_firestore, etc.)
- Remove Django dependency completely

Let me know if you'd like help switching to Firebase!

## 🌐 CORS Configuration

Add to `settings.py`:

```python
INSTALLED_APPS = [
    ...
    'rest_framework',
    'corsheaders',
    'api',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    ...
]

CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

# For development only - allows all origins
CORS_ALLOW_ALL_ORIGINS = True
```

## 📚 Resources

- [Django REST Framework Documentation](https://www.django-rest-framework.org/)
- [Django Documentation](https://docs.djangoproject.com/)

