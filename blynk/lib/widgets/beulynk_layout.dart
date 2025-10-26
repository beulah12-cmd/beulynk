import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'beulynk_logo.dart';
import 'custom_footer.dart';
import '../screens/landing_page.dart';
import '../screens/about_page.dart';
import '../screens/how_it_works_page.dart';
import '../screens/testimonials_page.dart';
import '../screens/contact_page.dart';
import '../screens/signin_page.dart';
import '../screens/signup_page.dart';

/// Responsive Navigation Items
class NavItem {
  final String title;
  final IconData icon;
  final Widget Function() builder;

  NavItem({required this.title, required this.icon, required this.builder});
}

/// Navigation configuration
class BeulynkNav {
  static final List<NavItem> items = [
    NavItem(
      title: 'Home',
      icon: Icons.home,
      builder: () => const LandingPage(),
    ),
    NavItem(title: 'About', icon: Icons.info, builder: () => const AboutPage()),
    NavItem(
      title: 'How It Works',
      icon: Icons.lightbulb,
      builder: () => const HowItWorksPage(),
    ),
    NavItem(
      title: 'Testimonials',
      icon: Icons.star,
      builder: () => const TestimonialsPage(),
    ),
    NavItem(
      title: 'Contact',
      icon: Icons.contact_mail,
      builder: () => const ContactPage(),
    ),
  ];
}

/// Shared App Bar for all screens
class BeulynkAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const BeulynkAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;
    final isTablet = screenWidth > 768 && screenWidth <= 1024;
    final isMobile = screenWidth <= 768;

    return AppBar(
      backgroundColor: const Color(0xFF1A1A2E).withOpacity(0.95),
      elevation: 0,
      leading: isMobile
          ? null // Let AppBar handle hamburger menu automatically
          : IconButton(
              icon: const BeulynkLogo.icon(size: 24, heartColor: Colors.white),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (route) => false,
                );
              },
            ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMobile) ...[
            IconButton(
              icon: const BeulynkLogo.icon(size: 24, heartColor: Colors.white),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(width: 8),
          ],
          Text(
            'BEULYNK',
            style: GoogleFonts.manrope(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      centerTitle: isMobile,
      actions: [
        // Desktop: Show full navigation tabs
        if (isDesktop) ..._buildDesktopNav(context),

        // Tablet: Show condensed navigation
        if (isTablet) ..._buildTabletNav(context),

        // Auth buttons (always visible on desktop/tablet)
        if (!isMobile) ...[
          const SizedBox(width: 16),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
            },
            child: Text(
              'Sign In',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE94560),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Sign Up',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],

        // Custom actions
        if (actions != null) ...actions!,
      ],
    );
  }

  List<Widget> _buildDesktopNav(BuildContext context) {
    return BeulynkNav.items.map((item) {
      final isActive = title == item.title;
      return TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => item.builder()),
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: GoogleFonts.inter(
                color: isActive ? const Color(0xFFE94560) : Colors.white,
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFFE94560),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildTabletNav(BuildContext context) {
    return BeulynkNav.items.map((item) {
      final isActive = title == item.title;
      return IconButton(
        icon: Icon(
          item.icon,
          color: isActive ? const Color(0xFFE94560) : Colors.white,
        ),
        tooltip: item.title,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => item.builder()),
          );
        },
      );
    }).toList();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Shared Footer for all screens (deprecated - use CustomFooter instead)
class BeulynkFooter extends StatelessWidget {
  const BeulynkFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomFooter();
  }
}

/// Mobile Drawer Menu
class BeulynkDrawer extends StatelessWidget {
  final String currentPage;

  const BeulynkDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A2E),
      child: Column(
        children: [
          // Drawer Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFE94560).withOpacity(0.8),
                  const Color(0xFFE94560).withOpacity(0.4),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BeulynkLogo.icon(size: 48, heartColor: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'BEULYNK',
                    style: GoogleFonts.manrope(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unity through connection',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...BeulynkNav.items.map((item) {
                  final isActive = currentPage == item.title;
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: isActive
                          ? const Color(0xFFE94560)
                          : Colors.white70,
                    ),
                    title: Text(
                      item.title,
                      style: GoogleFonts.inter(
                        color: isActive
                            ? const Color(0xFFE94560)
                            : Colors.white,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    selected: isActive,
                    selectedTileColor: const Color(0xFFE94560).withOpacity(0.1),
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      if (!isActive) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => item.builder(),
                          ),
                        );
                      }
                    },
                  );
                }),

                const Divider(color: Colors.white24, height: 32),

                // Auth Options
                ListTile(
                  leading: const Icon(Icons.login, color: Colors.white70),
                  title: Text(
                    'Sign In',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add, color: Colors.white70),
                  title: Text(
                    'Sign Up',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              '© 2024 BEULYNK\nBeulah Humanity Reconciliation',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared Layout Widget for all screens
class BeulynkLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? appBarActions;
  final bool showBackButton;
  final bool showFooter;

  const BeulynkLayout({
    super.key,
    required this.title,
    required this.body,
    this.appBarActions,
    this.showBackButton = false,
    this.showFooter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BeulynkAppBar(
        title: title,
        actions: appBarActions,
        showBackButton: showBackButton,
      ),
      drawer: BeulynkDrawer(currentPage: title),
      body: Column(
        children: [
          // Main content
          Expanded(child: body),

          // Footer
          if (showFooter) const BeulynkFooter(),
        ],
      ),
    );
  }
}
