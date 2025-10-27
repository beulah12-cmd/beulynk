# 🧪 Beulynk Problem Posts + Map System — Testing Guide

## ✅ **Implementation Complete!**

All features are now implemented and ready for testing.

---

## 🚀 **Quick Start Testing**

### **1. Backend Testing**

#### Check Django Admin
1. Access: `https://beulynk-backend.onrender.com/admin/`
2. Login with superuser credentials
3. You should see the **Post** model with fields:
   - title, description, photo, video, latitude, longitude, is_confirmed, created_at

#### Test API Endpoints
```bash
# Get all posts
curl https://beulynk-backend.onrender.com/api/posts/

# Get approved posts only (for map)
curl https://beulynk-backend.onrender.com/api/approved-posts/

# API root (list all endpoints)
curl https://beulynk-backend.onrender.com/api/
```

---

### **2. Flutter App Testing**

#### Run on Android
```bash
cd C:\Users\leona\BLYNK_PROJECT\blynk
flutter run -d RR8W6057XAF
```

#### Test Flow

1. **Login/Register**
   - Sign up or sign in with credentials
   - Should navigate to HomeScreen with bottom navigation

2. **Posts Tab**
   - Tap "Posts" in bottom navigation
   - See "No posts yet" message initially
   - Tap "Report Problem" FAB
   - Fill in title and description
   - Optional: Add photo
   - Submit
   - Post should appear in feed with "Pending" badge

3. **Admin Approval**
   - Go to Django admin
   - Find the newly created post
   - Toggle `is_confirmed = True`
   - Save

4. **Map Tab**
   - Tap "Map" in bottom navigation
   - Should see Google Maps with marker(s)
   - Tap marker to see InfoWindow
   - Info banner shows count of approved posts

5. **Refresh Posts Feed**
   - Go back to Posts tab
   - Pull down to refresh
   - Approved post should now show "Approved" badge

6. **Explore Tab**
   - Tap "Explore" in bottom navigation
   - See action cards (Volunteer, Donor, Request Help)
   - See stats section with NGO info

7. **Info Tab**
   - Tap "Info" in bottom navigation
   - See user profile (username, email, role)
   - Tap "Logout" button
   - Confirm logout
   - Should return to SignInPage

---

## 🎯 **Expected Behavior**

### **Posts Feed**
- Shows all posts (pending + approved)
- Displays photo if available
- Shows "Pending" (orange) or "Approved" (green) badge
- Shows username and timestamp
- Pull to refresh works
- Create post dialog allows image picker

### **Map**
- Shows only approved posts as markers
- Markers clickable with InfoWindow
- Refresh button reloads approved posts
- Info banner shows count
- Default to San Francisco if no posts

### **User Isolation**
- Each user can create posts
- Each user sees their own posts in feed
- Posts assigned to correct user automatically
- No cross-user data leakage

---

## 🔍 **Debugging Tips**

### **Check API Service Logs**
Look for these prints in Flutter console:
```
🔗 GET /api/posts/
📥 200 [...]
🔗 POST /api/posts/
📤 Title: Test Problem
📤 Has photo: true/false
📥 201 [...]
```

### **Check Backend Logs**
On Render dashboard, check logs for:
- POST /api/posts/ (should return 201)
- GET /api/posts/ (should return 200)
- GET /api/approved-posts/ (should return only confirmed posts)

### **Common Issues**

1. **Photos not displaying**
   - Check media URL configuration
   - Ensure backend serves media files
   - Check CORS settings

2. **Map not showing markers**
   - Verify posts have latitude/longitude
   - Check Google Maps API key (if required)
   - Ensure posts are approved

3. **Navigation issues**
   - Verify HomeScreen imports in signin/signup pages
   - Check navigation after login/register

4. **API errors**
   - Check backend URL in `api_config.dart`
   - Verify token is saved in SharedPreferences
   - Check CORS configuration

---

## 📋 **Files to Verify**

### **Backend**
- ✅ `blynk_backend/api/models.py` — Post model exists
- ✅ `blynk_backend/api/serializers.py` — PostSerializer exists
- ✅ `blynk_backend/api/views.py` — PostViewSet and ApprovedPostViewSet exist
- ✅ `blynk_backend/api/urls.py` — Router registrations exist
- ✅ `blynk_backend/api/admin.py` — Post registered with actions

### **Frontend**
- ✅ `blynk/lib/services/api_service.dart` — getAllPosts, getApprovedPosts, createPost methods
- ✅ `blynk/lib/screens/home_screen.dart` — Bottom navigation
- ✅ `blynk/lib/screens/posts_screen.dart` — Feed + create dialog
- ✅ `blynk/lib/screens/map_screen.dart` — Google Maps + markers
- ✅ `blynk/lib/screens/explore_screen.dart` — Action cards + stats
- ✅ `blynk/lib/screens/info_screen.dart` — Profile + logout
- ✅ `blynk/pubspec.yaml` — google_maps_flutter, image_picker added

---

## 🎉 **Success Criteria**

✅ Users can create posts with photos
✅ Posts appear immediately in feed with "Pending" status
✅ Admin can approve posts in Django admin
✅ Approved posts appear on map as markers
✅ Users can tap markers to see post details
✅ Posts feed shows all posts with status badges
✅ User isolation works correctly
✅ Navigation between tabs works smoothly
✅ Logout returns to sign-in page

---

## 🚀 **Ready to Test!**

Run the Flutter app and test the complete flow!

```bash
cd C:\Users\leona\BLYNK_PROJECT\blynk
flutter run -d RR8W6057XAF
```

