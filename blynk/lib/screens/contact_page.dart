import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/beulynk_layout.dart';
import '../widgets/hero_section_widget.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_buttons.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isSubmitting = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Thank you! We\'ll get back to you soon.',
              style: GoogleFonts.inter(),
            ),
            backgroundColor: const Color(0xFFE94560),
          ),
        );

        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BeulynkLayout(
      title: 'Contact',
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeroSectionWidget(
                  title: 'Get In Touch',
                  subtitle: 'We\'d love to hear from you',
                  icon: Icons.mail_outline,
                  minHeight: 280.h,
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),

                      // Contact Info Cards
                      Wrap(
                        spacing: 16.w,
                        runSpacing: 16.h,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildContactInfoCard(
                            icon: FontAwesomeIcons.envelope,
                            title: 'Email',
                            info: 'contact@beulynk.org',
                          ),
                          _buildContactInfoCard(
                            icon: FontAwesomeIcons.phone,
                            title: 'Phone',
                            info: '+1 (555) 123-4567',
                          ),
                          _buildContactInfoCard(
                            icon: FontAwesomeIcons.locationDot,
                            title: 'Location',
                            info: 'Global Headquarters',
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms).scale(),

                      SizedBox(height: 40.h),

                      // Contact Form
                      Container(
                        constraints: BoxConstraints(maxWidth: 600.w),
                        padding: EdgeInsets.all(32.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
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
                              Text(
                                'Send us a Message',
                                style: GoogleFonts.manrope(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 24.h),

                              CustomTextField(
                                controller: _nameController,
                                label: 'Your Name',
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
                                controller: _messageController,
                                label: 'Message',
                                hint: 'Type your message here...',
                                prefixIcon: Icons.message_outlined,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your message';
                                  }
                                  if (value.length < 10) {
                                    return 'Message must be at least 10 characters';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 32.h),

                              PrimaryButton(
                                text: 'Send Message',
                                onPressed: _handleSubmit,
                                isLoading: _isSubmitting,
                                width: double.infinity,
                                icon: Icons.send,
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

                      SizedBox(height: 40.h),

                      // Social Media Links
                      Container(
                        constraints: BoxConstraints(maxWidth: 600.w),
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE94560).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: const Color(0xFFE94560).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Follow Us',
                              style: GoogleFonts.manrope(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialButton(FontAwesomeIcons.facebook),
                                SizedBox(width: 16.w),
                                _buildSocialButton(FontAwesomeIcons.xTwitter),
                                SizedBox(width: 16.w),
                                _buildSocialButton(FontAwesomeIcons.instagram),
                                SizedBox(width: 16.w),
                                _buildSocialButton(FontAwesomeIcons.linkedin),
                              ],
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 600.ms),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoCard({
    required IconData icon,
    required String title,
    required String info,
  }) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          FaIcon(
            icon,
            size: 32.w,
            color: const Color(0xFFE94560),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            info,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: FaIcon(
          icon,
          size: 24.w,
          color: Colors.white,
        ),
      ),
    );
  }
}
