# 🚀 Render Setup Instructions for BEULYNK Backend

## Your Backend is Deployed at:
**https://beulynk-backend.onrender.com**

---

## 📋 Manual Setup Steps on Render

Since your backend is already deployed, you need to run these commands in the Render shell to complete the setup.

### Step 1: Access Render Shell

1. Go to your Render dashboard
2. Click on your service: **beulynk-backend**
3. Click on the **"Shell"** tab

### Step 2: Run Database Migrations

In the Render shell, run:

```bash
cd blynk_backend
python manage.py migrate
```

This will create all database tables.

### Step 3: Initialize NGO Data

```bash
python manage.py init_ngo_data
```

This populates the database with NGO information.

### Step 4: Create Admin User

```bash
python manage.py createsuperuser
```

Follow the prompts to create an admin account.

### Step 5: Test Endpoints

Visit these URLs to verify everything works:

- **NGO Info:** https://beulynk-backend.onrender.com/api/ngo-info/
- **Admin Panel:** https://beulynk-backend.onrender.com/admin/
- **API Root:** https://beulynk-backend.onrender.com/api/

---

## 🔄 Update Build Command for Future Deployments

To make migrations run automatically on future deployments:

1. Go to your service on Render
2. Click **"Settings"** tab
3. Find **"Build & Deploy"** section
4. Update **"Build Command"** to:
   ```
   cd blynk_backend && pip install -r requirements.txt && python manage.py migrate && python manage.py collectstatic --noinput
   ```
5. Click **"Save Changes"**

---

## ✅ Environment Variables

Make sure these are set in Render:

```
DATABASE_URL = [Your Aiven PostgreSQL connection string]
DEBUG = False
ALLOWED_HOSTS = beulynk-backend.onrender.com,localhost,127.0.0.1
SECRET_KEY = [Auto-generated or custom]
```

---

## 🌐 CORS Configuration

Your settings already allow all origins. If you want to restrict to specific domains:

Edit `blynk_backend/blynk_backend/settings.py`:

```python
# Change from:
CORS_ALLOW_ALL_ORIGINS = True

# To:
CORS_ALLOW_ALL_ORIGINS = False
CORS_ALLOWED_ORIGINS = [
    "https://your-frontend-domain.com",
    "http://localhost:3000",
]
```

Then push to GitHub and Render will auto-deploy.

---

## 🎉 After Setup

Your backend will be fully functional with:
✅ All database tables created
✅ NGO information initialized
✅ Admin panel accessible
✅ All API endpoints working
✅ CORS configured for frontend
✅ Automatic migrations on deploy

---

## 📱 Connect Flutter Frontend

Your Flutter app is already configured to use:
```
https://beulynk-backend.onrender.com
```

Just run:
```bash
cd blynk
flutter pub get
flutter run -d chrome
```

The frontend will automatically connect to your live backend!

