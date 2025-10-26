import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_footer.dart';
import 'signin_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _emailSent ? _buildSuccessMessage() : _buildResetForm(),
              const CustomFooter(),
            ],
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
              child: Icon(
                Icons.lock_reset,
                size: 60.w,
                color: const Color(0xFFE94560),
              ),
            ).animate().fadeIn(duration: 600.ms).scale(),

            SizedBox(height: 24.h),

            Text(
              'Reset Password',
              style: GoogleFonts.manrope(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

            SizedBox(height: 12.h),

            Text(
              'Enter your email to receive a password reset link',
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

  Widget _buildResetForm() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: 500.w,
      ),
      padding: EdgeInsets.all(32.w),
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

            SizedBox(height: 32.h),

            PrimaryButton(
              text: 'Send Reset Link',
              onPressed: _handleResetPassword,
              isLoading: _isLoading,
              width: double.infinity,
              icon: Icons.send,
            ),

            SizedBox(height: 24.h),

            CustomTextButton(
              text: 'Back to Sign In',
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
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildSuccessMessage() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: 500.w,
      ),
      padding: EdgeInsets.all(40.w),
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFFE94560).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE94560).withOpacity(0.1),
            ),
            child: Icon(
              Icons.check_circle,
              size: 60.w,
              color: const Color(0xFFE94560),
            ),
          ).animate().fadeIn(duration: 600.ms).scale(),

          SizedBox(height: 24.h),

          Text(
            'Email Sent!',
            style: GoogleFonts.manrope(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'We\'ve sent a password reset link to:',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          Text(
            _emailController.text,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFE94560),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24.h),

          Text(
            'Please check your inbox and follow the instructions to reset your password.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.6),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 32.h),

          PrimaryButton(
            text: 'Back to Sign In',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
              );
            },
            width: double.infinity,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }
}

