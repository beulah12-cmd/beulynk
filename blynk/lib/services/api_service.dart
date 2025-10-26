import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/user_model.dart';
import '../models/ngo_info_model.dart';
import 'auth_service.dart';

class ApiService {
  static final String baseUrl = ApiConfig.getBaseUrl();

  /// Get headers with authentication token
  static Future<Map<String, String>> _getHeaders({
    bool includeAuth = false,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth) {
      final token = await AuthService.getToken();
      if (token != null) {
        headers['Authorization'] = 'Token $token';
      }
    }

    return headers;
  }

  /// Register new user
  static Future<AuthResponse> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String role, // 'volunteer', 'donor', or 'help_seeker'
  }) async {
    try {
      final url = '${baseUrl}auth/register/';
      final data = {
        'username': username,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'first_name': firstName,
        'last_name': lastName,
        'role': role,
      };

      print('🔗 POST $url');
      print('📤 ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(),
        body: jsonEncode(data),
      );

      print('📥 ${response.statusCode} ${response.body}');

      final decodedData = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(decodedData);

      // Save auth data if successful
      if (authResponse.success &&
          authResponse.token != null &&
          authResponse.user != null) {
        await AuthService.saveAuthData(
          token: authResponse.token!,
          user: authResponse.user!,
        );
      }

      return authResponse;
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// Login user
  static Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = '${baseUrl}auth/login/';
      final data = {'username': username, 'password': password};

      print('🔗 POST $url');
      print('📤 ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(),
        body: jsonEncode(data),
      );

      print('📥 ${response.statusCode} ${response.body}');

      final decodedData = jsonDecode(response.body);
      final authResponse = AuthResponse.fromJson(decodedData);

      // Save auth data if successful
      if (authResponse.success &&
          authResponse.token != null &&
          authResponse.user != null) {
        await AuthService.saveAuthData(
          token: authResponse.token!,
          user: authResponse.user!,
        );
      }

      return authResponse;
    } catch (e) {
      return AuthResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  /// Logout user
  static Future<bool> logout() async {
    try {
      final url = '${baseUrl}auth/logout/';
      print('🔗 POST $url');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(includeAuth: true),
      );

      print('📥 ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        await AuthService.clearAuthData();
        return true;
      }

      return false;
    } catch (e) {
      // Clear local data even if API call fails
      await AuthService.clearAuthData();
      return true;
    }
  }

  /// Get NGO information
  static Future<NGOInfo?> getNGOInfo() async {
    try {
      final url = '${baseUrl}ngo-info/';
      print('🔗 GET $url');

      final response = await http.get(
        Uri.parse(url),
        headers: await _getHeaders(),
      );

      print('📥 ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['ngo_info'] != null) {
          return NGOInfo.fromJson(data['ngo_info']);
        }
      }

      return null;
    } catch (e) {
      print('Error fetching NGO info: $e');
      return null;
    }
  }

  /// Submit volunteer request
  static Future<Map<String, dynamic>> submitVolunteerRequest({
    required String skills,
    required String availability,
    required String motivation,
  }) async {
    try {
      final url = '${baseUrl}volunteer/';
      final data = {
        'skills': skills,
        'availability': availability,
        'motivation': motivation,
      };

      print('🔗 POST $url');
      print('📤 ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(includeAuth: true),
        body: jsonEncode(data),
      );

      print('📥 ${response.statusCode} ${response.body}');

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  /// Submit donor request
  static Future<Map<String, dynamic>> submitDonorRequest({
    required String donationType, // 'one_time', 'monthly', 'yearly'
    double? amount,
    String? message,
  }) async {
    try {
      final url = '${baseUrl}donor/';
      final data = {
        'donation_type': donationType,
        if (amount != null) 'amount': amount.toString(),
        if (message != null) 'message': message,
      };

      print('🔗 POST $url');
      print('📤 ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(includeAuth: true),
        body: jsonEncode(data),
      );

      print('📥 ${response.statusCode} ${response.body}');

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  /// Submit help request
  static Future<Map<String, dynamic>> submitHelpRequest({
    required String
    category, // 'financial', 'medical', 'education', 'food', 'shelter', 'other'
    required String title,
    required String description,
    required String urgency, // 'low', 'medium', 'high', 'critical'
  }) async {
    try {
      final url = '${baseUrl}help-request/';
      final data = {
        'category': category,
        'title': title,
        'description': description,
        'urgency': urgency,
      };

      print('🔗 POST $url');
      print('📤 ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(includeAuth: true),
        body: jsonEncode(data),
      );

      print('📥 ${response.statusCode} ${response.body}');

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }

  /// Submit contact message
  static Future<Map<String, dynamic>> submitContactMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final url = '${baseUrl}contact/';
      final data = {'name': name, 'email': email, 'message': message};

      print('🔗 POST $url');
      print('📤 ${jsonEncode(data)}');

      final response = await http.post(
        Uri.parse(url),
        headers: await _getHeaders(),
        body: jsonEncode(data),
      );

      print('📥 ${response.statusCode} ${response.body}');

      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: ${e.toString()}'};
    }
  }
}
