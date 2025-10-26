/// API Configuration for BEULYNK Backend
class ApiConfig {
  /// Production API base URL (includes /api/ at the end)
  static const String apiBaseUrl = 'https://beulynk-backend.onrender.com/api/';
  
  // Development URLs
  static const String localhostUrl = 'http://localhost:8000/api/';
  static const String androidEmulatorUrl = 'http://10.0.2.2:8000/api/';
  
  /// Get the base URL for API requests
  /// Currently set to production Render deployment
  static String getBaseUrl() {
    return apiBaseUrl;
  }
  
  /// Get base URL for physical Android device
  /// Replace with your computer's IP address
  static String getPhysicalDeviceUrl(String ipAddress) {
    return 'http://$ipAddress:8000/api/';
  }
}
