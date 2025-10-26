import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/beulynk_layout.dart';
import '../widgets/hero_section_widget.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BeulynkLayout(
      title: 'How It Works',
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
                  title: 'How It Works',
                  subtitle: 'Simple steps to connect, give, and make a difference',
                  icon: Icons.lightbulb_outline,
                  minHeight: 280.h,
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),

                      _buildStepCard(
                        context,
                        step: '1',
                        icon: FontAwesomeIcons.userPlus,
                        title: 'Create Your Account',
                        description:
                            'Sign up in minutes with your email. Choose your role as a donor, volunteer, or someone seeking help.',
                        delay: 200,
                      ),

                      SizedBox(height: 20.h),

                      _buildStepCard(
                        context,
                        step: '2',
                        icon: FontAwesomeIcons.magnifyingGlass,
                        title: 'Explore Opportunities',
                        description:
                            'Browse through verified causes, projects, and communities that align with your passion and values.',
                        delay: 400,
                      ),

                      SizedBox(height: 20.h),

                      _buildStepCard(
                        context,
                        step: '3',
                        icon: FontAwesomeIcons.handHoldingHeart,
                        title: 'Make Your Contribution',
                        description:
                            'Donate, volunteer, or request assistance. Every action creates a ripple of positive change.',
                        delay: 600,
                      ),

                      SizedBox(height: 20.h),

                      _buildStepCard(
                        context,
                        step: '4',
                        icon: FontAwesomeIcons.chartLine,
                        title: 'Track Your Impact',
                        description:
                            'See the real-time difference you\'re making. Get updates, stories, and transparent reports on your contributions.',
                        delay: 800,
                      ),

                      SizedBox(height: 40.h),

                      // Call to Action
                      Container(
                        constraints: BoxConstraints(maxWidth: 600.w),
                        padding: EdgeInsets.all(32.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFE94560),
                              Color(0xFFD63447),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 48.w,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Ready to Get Started?',
                              style: GoogleFonts.manrope(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Join thousands making a difference today',
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 1000.ms).scale(),

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

  Widget _buildStepCard(
    BuildContext context, {
    required String step,
    required IconData icon,
    required String title,
    required String description,
    required int delay,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: 700.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Number Circle
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE94560),
                  Color(0xFFD63447),
                ],
              ),
            ),
            child: Center(
              child: Text(
                step,
                style: GoogleFonts.manrope(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: 20.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      icon,
                      size: 24.w,
                      color: const Color(0xFFE94560),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.1, end: 0);
  }
}
