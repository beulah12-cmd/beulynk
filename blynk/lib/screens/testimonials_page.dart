import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/beulynk_layout.dart';
import '../widgets/hero_section_widget.dart';

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BeulynkLayout(
      title: 'Testimonials',
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
                  title: 'What People Say',
                  subtitle: 'Real stories from our community',
                  icon: Icons.star,
                  minHeight: 280.h,
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),

                      _buildTestimonialCard(
                        name: 'Sarah Johnson',
                        role: 'Donor',
                        testimonial:
                            'BEULYNK made it so easy to help those in need. I love how transparent and direct the platform is. Every donation feels meaningful and I can see exactly where my contribution goes.',
                        rating: 5,
                        delay: 200,
                      ),

                      SizedBox(height: 20.h),

                      _buildTestimonialCard(
                        name: 'Michael Chen',
                        role: 'Volunteer',
                        testimonial:
                            'Being part of this community has been incredibly rewarding. Every contribution truly makes a difference. The platform connects me with opportunities that align with my skills.',
                        rating: 5,
                        delay: 400,
                      ),

                      SizedBox(height: 20.h),

                      _buildTestimonialCard(
                        name: 'Amara Okafor',
                        role: 'Community Leader',
                        testimonial:
                            'BEULYNK has transformed how we connect with supporters. The platform is intuitive, efficient, and has helped us reach more people than ever before.',
                        rating: 5,
                        delay: 600,
                      ),

                      SizedBox(height: 20.h),

                      _buildTestimonialCard(
                        name: 'David Martinez',
                        role: 'Beneficiary',
                        testimonial:
                            'When I needed help the most, BEULYNK connected me with amazing people who cared. This platform gave me hope and practical support when I needed it.',
                        rating: 5,
                        delay: 800,
                      ),

                      SizedBox(height: 20.h),

                      _buildTestimonialCard(
                        name: 'Lisa Anderson',
                        role: 'Monthly Donor',
                        testimonial:
                            'I appreciate the regular updates and transparency. Knowing exactly how my monthly contributions help real people keeps me motivated to continue giving.',
                        rating: 5,
                        delay: 1000,
                      ),

                      SizedBox(height: 20.h),

                      _buildTestimonialCard(
                        name: 'James Wilson',
                        role: 'Corporate Partner',
                        testimonial:
                            'Our company partnered with BEULYNK for our CSR initiatives. The professionalism, impact tracking, and community engagement have exceeded our expectations.',
                        rating: 5,
                        delay: 1200,
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
                              'Join Our Community',
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
                              'Be part of the stories that inspire change',
                              style: GoogleFonts.inter(
                                fontSize: 15.sp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 1400.ms).scale(),

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

  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String testimonial,
    required int rating,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30.r,
                backgroundColor: const Color(0xFFE94560).withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFFE94560),
                  size: 32.w,
                ),
              ),

              SizedBox(width: 16.w),

              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.manrope(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      role,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFFE94560),
                      ),
                    ),
                  ],
                ),
              ),

              // Rating Stars
              Row(
                children: List.generate(
                  rating,
                  (index) => Icon(
                    Icons.star,
                    color: const Color(0xFFE94560),
                    size: 18.w,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Testimonial Text
          Text(
            '"$testimonial"',
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              color: Colors.white70,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.1, end: 0);
  }
}
