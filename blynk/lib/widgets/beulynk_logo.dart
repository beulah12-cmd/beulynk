import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// BEULYNK Logo Widget
///
/// A clean, minimalist logo that matches the splash screen design.
/// Features a white heart icon with "BEULYNK" text below.
class BeulynkLogo extends StatelessWidget {
  final double? size;
  final Color? heartColor;
  final Color? textColor;
  final bool showText;
  final double? heartSize;
  final double? textSize;

  const BeulynkLogo({
    super.key,
    this.size,
    this.heartColor,
    this.textColor,
    this.showText = true,
    this.heartSize,
    this.textSize,
  });

  /// App Icon version - just the heart
  const BeulynkLogo.icon({super.key, this.size, this.heartColor})
    : showText = false,
      textColor = null,
      heartSize = null,
      textSize = null;

  /// Full logo with text
  const BeulynkLogo.full({
    super.key,
    this.size,
    this.heartColor,
    this.textColor,
    this.heartSize,
    this.textSize,
  }) : showText = true;

  @override
  Widget build(BuildContext context) {
    final effectiveHeartColor = heartColor ?? Colors.white;

    // Always show just the heart icon (no text)
    return SizedBox(
      width: size,
      height: size,
      child: Icon(
        Icons.favorite,
        color: effectiveHeartColor,
        size: heartSize ?? (size != null ? size! * 0.8 : 80),
      ),
    );
  }
}

/// Predefined logo sizes for different use cases
class BeulynkLogoSize {
  static const double small = 40;
  static const double medium = 80;
  static const double large = 120;
  static const double xlarge = 200;

  // App icon sizes
  static const double appIcon16 = 16;
  static const double appIcon24 = 24;
  static const double appIcon32 = 32;
  static const double appIcon48 = 48;
  static const double appIcon64 = 64;
  static const double appIcon128 = 128;
  static const double appIcon256 = 256;
  static const double appIcon512 = 512;
}

/// Logo variants for different contexts
class BeulynkLogoVariants {
  /// White logo for dark backgrounds
  static const BeulynkLogo white = BeulynkLogo(
    heartColor: Colors.white,
    textColor: Colors.white,
  );

  /// Dark logo for light backgrounds
  static const BeulynkLogo dark = BeulynkLogo(
    heartColor: Color(0xFF1A2347),
    textColor: Color(0xFF1A2347),
  );

  /// Accent color logo
  static const BeulynkLogo accent = BeulynkLogo(
    heartColor: Color(0xFFE94560),
    textColor: Color(0xFFE94560),
  );

  /// App icon variants
  static const BeulynkLogo appIconWhite = BeulynkLogo.icon(
    heartColor: Colors.white,
  );

  static const BeulynkLogo appIconDark = BeulynkLogo.icon(
    heartColor: Color(0xFF1A2347),
  );

  static const BeulynkLogo appIconAccent = BeulynkLogo.icon(
    heartColor: Color(0xFFE94560),
  );
}
