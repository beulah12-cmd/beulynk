class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? role;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
    };
  }
}

class AuthResponse {
  final bool success;
  final String? message;
  final String? token;
  final User? user;
  final Map<String, dynamic>? errors;

  AuthResponse({
    required this.success,
    this.message,
    this.token,
    this.user,
    this.errors,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      token: json['token'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      errors: json['errors'] as Map<String, dynamic>?,
    );
  }
}
