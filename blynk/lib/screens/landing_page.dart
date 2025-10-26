import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/beulynk_logo.dart';
import '../widgets/beulynk_layout.dart';
import '../widgets/custom_footer.dart';
import 'signin_page.dart';
import 'signup_page.dart';
import 'about_page.dart';
import 'how_it_works_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BeulynkAppBar(
        title: 'Home',
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
      drawer: const BeulynkDrawer(currentPage: 'Home'),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildModernHeroSection(),
              _buildAboutPreview(),
              _buildHowItWorksPreview(),
              _buildTestimonialsSection(),
              _buildCallToActionSection(),
              const CustomFooter(),
            ],
          ),
        ),
      ),
    );
  }

  /// Modern, Professional Hero Section
  Widget _buildModernHeroSection() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.85,
      ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with elegant animation
              Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                      border: Border.all(
                        color: const Color(0xFFE94560).withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE94560).withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: const BeulynkLogo.icon(
                        size: 60,
                        heartColor: Colors.white,
                      ),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 3000.ms,
                    color: const Color(0xFFE94560).withOpacity(0.3),
                  )
                  .then()
                  .shake(duration: 500.ms, hz: 2),

              SizedBox(height: 32.h),

              // Main Headline
              Text(
                'Welcome to BEULYNK',
                style: GoogleFonts.manrope(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3, end: 0),

              SizedBox(height: 16.h),

              // Animated Slogan
              SizedBox(
                height: 30.h,
                child: DefaultTextStyle(
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFE94560),
                    letterSpacing: 0.5,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Unity through connection',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Hope through humanity',
                        speed: const Duration(milliseconds: 100),
                      ),
                      TypewriterAnimatedText(
                        'Change through compassion',
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Subtitle/Description
              Container(
                constraints: BoxConstraints(maxWidth: 600.w),
                child: Text(
                  'Connecting people in need with donors and helpers to create meaningful change together',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.6,
                    letterSpacing: 0.2,
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              ),

              SizedBox(height: 40.h),

              // CTA Buttons - Responsive
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;

                  if (isMobile) {
                    // Stack buttons vertically on mobile
                    return Column(
                      children: [
                        _buildPrimaryButton('Get Started', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        }),
                        SizedBox(height: 16.h),
                        _buildSecondaryButton('Sign In', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        }),
                      ],
                    );
                  } else {
                    // Place buttons side by side on larger screens
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPrimaryButton('Get Started', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        }),
                        SizedBox(width: 16.w),
                        _buildSecondaryButton('Sign In', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ),
                          );
                        }),
                      ],
                    );
                  }
                },
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),

              SizedBox(height: 40.h),

              // Trust indicators / Stats preview
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 32.w,
                runSpacing: 16.h,
                children: [
                  _buildStatIndicator('10K+', 'Lives Impacted'),
                  _buildStatIndicator('500+', 'Active Donors'),
                  _buildStatIndicator('50+', 'Communities'),
                ],
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE94560),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        elevation: 8,
        shadowColor: const Color(0xFFE94560).withOpacity(0.4),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 2),
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 18.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.manrope(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildStatIndicator(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE94560),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.white70),
        ),
      ],
    );
  }

  /// About Section - Compact Preview
  Widget _buildAboutPreview() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E).withOpacity(0.8),
            const Color(0xFF16213E).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE94560).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.info_outline,
              color: const Color(0xFFE94560),
              size: 32.w,
            ),
          ),

          SizedBox(width: 20.w),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Us',
                  style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Bridging compassion and action, connecting donors, volunteers, and those in need.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Arrow Button
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFFE94560),
              size: 20.w,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0);
  }

  /// How It Works Section - Compact Preview
  Widget _buildHowItWorksPreview() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF16213E).withOpacity(0.6),
            const Color(0xFF0F3460).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFE94560).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.lightbulb_outline,
              color: const Color(0xFFE94560),
              size: 32.w,
            ),
          ),

          SizedBox(width: 20.w),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How It Works',
                  style: GoogleFonts.manrope(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Simple steps to connect, give, and make a difference.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Arrow Button
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HowItWorksPage()),
              );
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFFE94560),
              size: 20.w,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0);
  }

  /// Testimonials Section
  Widget _buildTestimonialsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1A2E).withOpacity(0.5),
            const Color(0xFF0F3460).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'What People Say',
            style: GoogleFonts.manrope(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: 60.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE94560),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 32.h),
          _buildTestimonialCard(
            'Sarah Johnson',
            'Donor',
            'BEULYNK made it so easy to help those in need. I love how transparent and direct the platform is!',
          ),
          SizedBox(height: 16.h),
          _buildTestimonialCard(
            'Michael Chen',
            'Volunteer',
            'Being part of this community has been incredibly rewarding. Every contribution truly makes a difference.',
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String name, String role, String testimonial) {
    return Container(
      constraints: BoxConstraints(maxWidth: 600.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: const Color(0xFFE94560).withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFFE94560),
                  size: 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.manrope(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    role,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFFE94560),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '"$testimonial"',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white70,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  /// Call to Action Section
  Widget _buildCallToActionSection() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
      padding: EdgeInsets.all(40.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE94560), Color(0xFFD63447)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE94560).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.favorite, color: Colors.white, size: 48.w)
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                duration: 1500.ms,
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
              ),
          SizedBox(height: 20.h),
          Text(
            'Join Us Today',
            style: GoogleFonts.manrope(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            'Be part of a community that creates real change',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 28.h),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFE94560),
              padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              elevation: 8,
            ),
            child: Text(
              'Get Started Now',
              style: GoogleFonts.manrope(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0);
  }
}
