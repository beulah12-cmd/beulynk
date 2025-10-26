import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/beulynk_logo.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_footer.dart';
import '../widgets/loading_overlay.dart';
import '../services/api_service.dart';
import 'signin_page.dart';
import 'landing_page.dart';

enum UserRole { volunteer, donor, requestHelp }

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  UserRole? _selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select how you\'d like to join',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please agree to the Terms and Conditions',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Call real API
        final role = _selectedRole == UserRole.volunteer
            ? 'volunteer'
            : _selectedRole == UserRole.donor
            ? 'donor'
            : 'help_seeker';

        final response = await ApiService.register(
          username: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
          firstName: _nameController.text.trim(),
          lastName: '',
          role: role,
        );

        if (mounted) {
          setState(() => _isLoading = false);

          if (response.success) {
            String roleText = _selectedRole == UserRole.volunteer
                ? 'Volunteer'
                : _selectedRole == UserRole.donor
                ? 'Donor'
                : 'Help Recipient';

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Welcome as a $roleText! Account created successfully.',
                  style: GoogleFonts.inter(),
                ),
                backgroundColor: const Color(0xFFE94560),
              ),
            );

            // Navigate to landing page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
              (route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  response.message ?? 'Registration failed. Please try again.',
                  style: GoogleFonts.inter(),
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: ${e.toString()}',
                style: GoogleFonts.inter(),
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildSignUpForm(),
                const CustomFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E),
            const Color(0xFF16213E),
            const Color(0xFF0F3460).withOpacity(0.9),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Logo
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
                border: Border.all(
                  color: const Color(0xFFE94560).withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: const BeulynkLogo.icon(size: 60, heartColor: Colors.white),
            ).animate().fadeIn(duration: 600.ms).scale(),

            SizedBox(height: 24.h),

            Text(
              'Join BEULYNK',
              style: GoogleFonts.manrope(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

            SizedBox(height: 12.h),

            Text(
              'Create an account to start making a difference',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                color: Colors.white.withOpacity(0.7),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 500.w),
      padding: EdgeInsets.all(32.w),
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Role Selection
            Text(
              'I want to join as:',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 12.h),

            _buildRoleOption(
              role: UserRole.volunteer,
              icon: Icons.volunteer_activism,
              title: 'Volunteer',
              description: 'Contribute your time and skills',
            ),

            SizedBox(height: 12.h),

            _buildRoleOption(
              role: UserRole.donor,
              icon: Icons.favorite,
              title: 'Donor',
              description: 'Support with financial contributions',
            ),

            SizedBox(height: 12.h),

            _buildRoleOption(
              role: UserRole.requestHelp,
              icon: Icons.help_outline,
              title: 'Request Help',
              description: 'Seek assistance from the community',
            ),

            SizedBox(height: 24.h),

            CustomTextField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Enter your full name',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            CustomTextField(
              controller: _emailController,
              label: 'Email Address',
              hint: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            CustomTextField(
              controller: _passwordController,
              label: 'Password',
              hint: 'Create a password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white.withOpacity(0.5),
                  size: 20.w,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            CustomTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.white.withOpacity(0.5),
                  size: 20.w,
                ),
                onPressed: () {
                  setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  );
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() => _agreeToTerms = value ?? false);
                  },
                  activeColor: const Color(0xFFE94560),
                  checkColor: Colors.white,
                ),
                Expanded(
                  child: Text(
                    'I agree to the Terms and Conditions',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32.h),

            PrimaryButton(
              text: 'Create Account',
              onPressed: _handleSignUp,
              isLoading: _isLoading,
              width: double.infinity,
            ),

            SizedBox(height: 24.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                CustomTextButton(
                  text: 'Sign In',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 16.h),

            CustomTextButton(
              text: 'Back to Home',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (route) => false,
                );
              },
              color: Colors.white.withOpacity(0.6),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildRoleOption({
    required UserRole role,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedRole == role;

    return InkWell(
      onTap: () {
        setState(() => _selectedRole = role);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE94560).withOpacity(0.15)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE94560)
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE94560)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: Colors.white, size: 24.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFFE94560),
                size: 24.w,
              ),
          ],
        ),
      ),
    );
  }
}
