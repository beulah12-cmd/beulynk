# GitHub & Render Deployment Guide for BEULYNK

## 📋 Step-by-Step Guide to Push to GitHub and Deploy on Render

### Prerequisites
- GitHub account
- Render account
- Git installed on your computer

---

## Step 1: Initialize Git Repository

```bash
# Navigate to your project root
cd C:\Users\leona\BLYNK_PROJECT

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: BEULYNK full-stack platform"
```

---

## Step 2: Create GitHub Repository

1. Go to [github.com](https://github.com)
2. Click **"New repository"**
3. Name it: `blynk-platform` (or any name you prefer)
4. Description: "Full-stack humanitarian platform - Flutter frontend with Django REST API"
5. Make it **Public** (or Private if you prefer)
6. **DO NOT** initialize with README, .gitignore, or license
7. Click **"Create repository"**

---

## Step 3: Push to GitHub

```bash
# Add GitHub remote (replace with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/blynk-platform.git

# Rename main branch if needed
git branch -M main

# Push to GitHub
git push -u origin main
```

If you have authentication issues, use:
```bash
# For HTTPS with token
git push https://YOUR_TOKEN@github.com/YOUR_USERNAME/blynk-platform.git main

# Or set up SSH keys and use SSH
```

---

## Step 4: Deploy Backend to Render

### 4.1 Create New Web Service on Render

1. Go to [render.com](https://render.com)
2. Sign up/Login
3. Click **"New +"** → **"Web Service"**
4. Connect your GitHub repository
5. Select your `blynk-platform` repository

### 4.2 Configure Backend Service

**Name:** `blynk-backend`

**Build & Deploy Settings:**
```
Root Directory: blynk_backend
Environment: Python 3
Build Command: pip install -r requirements.txt && python manage.py migrate && python manage.py init_ngo_data
Start Command: python manage.py runserver 0.0.0.0:$PORT
```

**Environment Variables:**
Click **"Add Environment Variable"** and add:

```
Name: SECRET_KEY
Value: [Generate a secure random key]
```

```
Name: DEBUG
Value: False
```

```
Name: ALLOWED_HOSTS
Value: blynk-backend.onrender.com
```

**Advanced Settings:**
- Plan: Free (or paid if you want)
- Region: Choose closest to you
- Branch: main
- Auto-Deploy: Yes

### 4.3 Deploy

1. Click **"Create Web Service"**
2. Wait for deployment to complete (5-10 minutes)
3. Once deployed, your backend will be at: `https://blynk-backend.onrender.com`

---

## Step 5: Deploy Frontend to Render

### 5.1 Build Flutter Web App

```bash
# Navigate to Flutter directory
cd blynk

# Build for web
flutter build web
```

This creates: `blynk/build/web/`

### 5.2 Create Static Site on Render

1. Go to [render.com](https://render.com)
2. Click **"New +"** → **"Static Site"**
3. Connect the same GitHub repository

**Settings:**
```
Name: blynk-web
Branch: main
Root Directory: blynk/build/web
Publish Directory: . (or leave empty)
```

**Environment Variables (if needed):**
```
BACKEND_URL: https://blynk-backend.onrender.com
```

### 5.3 Deploy

1. Click **"Create Static Site"**
2. Wait for deployment
3. Your app will be at: `https://blynk-web.onrender.com`

---

## Step 6: Update Frontend to Use Deployed Backend

### Update API Configuration

Edit `blynk/lib/config/api_config.dart`:

```dart
static String getBaseUrl() {
  // For production, use deployed backend
  return 'https://blynk-backend.onrender.com';
  
  // For local development
  // return 'http://localhost:8000';
}
```

### Rebuild and Deploy

```bash
# Update API config first, then:
cd blynk
flutter build web

# Commit and push changes
cd ..
git add .
git commit -m "Update API config for production deployment"
git push
```

---

## Step 7: Test Deployment

### Test Backend
Visit: `https://blynk-backend.onrender.com/api/ngo-info/`

Should return JSON with NGO information.

### Test Frontend
Visit: `https://blynk-web.onrender.com`

Should show your BEULYNK app.

---

## 🔧 Troubleshooting

### Backend Issues

**Issue:** CORS errors
**Solution:** Check that `django-cors-headers` is in requirements.txt

**Issue:** Database errors
**Solution:** Run migrations manually:
```bash
# SSH into render console (if available)
python manage.py migrate
python manage.py init_ngo_data
```

**Issue:** Static files not loading
**Solution:** Add to settings.py:
```python
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]
```

### Frontend Issues

**Issue:** API connection failed
**Solution:** 
1. Check CORS settings in backend
2. Verify backend URL in api_config.dart
3. Check browser console for errors

**Issue:** Build errors
**Solution:**
```bash
flutter clean
flutter pub get
flutter build web
```

---

## 📝 Additional Configuration Files

### For PostgreSQL (Production Database)

Update `blynk_backend/blynk_backend/settings.py`:

```python
import os
import dj_database_url

DATABASES = {
    'default': dj_database_url.config(
        default=os.environ.get('DATABASE_URL')
    )
}
```

Add to requirements.txt:
```
dj-database-url
psycopg2-binary
```

---

## 🎉 Success Checklist

- [ ] Code pushed to GitHub
- [ ] Backend deployed on Render
- [ ] Frontend deployed on Render
- [ ] Backend URL accessible
- [ ] Frontend URL accessible
- [ ] API calls working
- [ ] Authentication working
- [ ] Database populated with NGO data
- [ ] CORS configured correctly

---

## 🔒 Security Checklist

- [ ] Change SECRET_KEY in production
- [ ] Set DEBUG = False
- [ ] Use environment variables for sensitive data
- [ ] Configure proper CORS origins
- [ ] Use HTTPS
- [ ] Set up proper firewall rules
- [ ] Enable database backups

---

## 📞 Support

If you encounter issues:
1. Check Render logs: Render dashboard → Your service → Logs
2. Check GitHub commits
3. Verify environment variables
4. Test endpoints with Postman or curl

---

## 🚀 Future Enhancements

- Add CI/CD pipeline
- Set up automated testing
- Add monitoring and analytics
- Configure custom domains
- Set up SSL certificates
- Add database backups
- Implement CDN for static files

---

**Your BEULYNK platform is now live! 🎊**

Backend: `https://blynk-backend.onrender.com`
Frontend: `https://blynk-web.onrender.com`

