import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui' as ui;

/// App Icon Generator for BEULYNK
///
/// This utility generates app icons for different platforms
/// by creating a simple heart icon with the BEULYNK branding.
class AppIconGenerator {
  static const List<int> iconSizes = [
    16,
    24,
    32,
    48,
    64,
    96,
    128,
    192,
    256,
    512,
  ];

  /// Generate app icon for a specific size
  static Future<void> generateAppIcon(int size) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    // Create a square canvas
    final paint = Paint()
      ..color =
          const Color(0xFF1A2347) // Dark navy blue background
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      paint,
    );

    // Draw heart icon
    final heartPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Calculate heart size (80% of canvas)
    final heartSize = size * 0.8;
    final heartX = (size - heartSize) / 2;
    final heartY = (size - heartSize) / 2;

    // Draw heart using path
    final heartPath = Path();
    final centerX = size / 2;
    final centerY = size / 2;
    final radius = heartSize / 4;

    // Heart shape using two circles and a triangle
    heartPath.addOval(
      Rect.fromCircle(
        center: Offset(centerX - radius, centerY - radius),
        radius: radius,
      ),
    );
    heartPath.addOval(
      Rect.fromCircle(
        center: Offset(centerX + radius, centerY - radius),
        radius: radius,
      ),
    );

    // Add triangle for heart point
    heartPath.moveTo(centerX, centerY + radius);
    heartPath.lineTo(centerX - radius * 1.5, centerY);
    heartPath.lineTo(centerX + radius * 1.5, centerY);
    heartPath.close();

    canvas.drawPath(heartPath, heartPaint);

    // Convert to image
    final picture = recorder.endRecording();
    final image = await picture.toImage(size, size);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final file = File('assets/images/beulynk_icon_${size}x$size.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      print('Generated: ${file.path}');
    }
  }

  /// Generate all app icons
  static Future<void> generateAllIcons() async {
    print('Generating BEULYNK app icons...');

    for (final size in iconSizes) {
      await generateAppIcon(size);
    }

    print('All app icons generated successfully!');
  }
}

/// Flutter app to generate icons
class IconGeneratorApp extends StatelessWidget {
  const IconGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BEULYNK Icon Generator',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const IconGeneratorScreen(),
    );
  }
}

class IconGeneratorScreen extends StatefulWidget {
  const IconGeneratorScreen({super.key});

  @override
  State<IconGeneratorScreen> createState() => _IconGeneratorScreenState();
}

class _IconGeneratorScreenState extends State<IconGeneratorScreen> {
  bool _isGenerating = false;
  String _status = '';

  Future<void> _generateIcons() async {
    setState(() {
      _isGenerating = true;
      _status = 'Generating icons...';
    });

    try {
      await AppIconGenerator.generateAllIcons();
      setState(() {
        _status = 'Icons generated successfully!';
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
      });
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BEULYNK Icon Generator'),
        backgroundColor: const Color(0xFF1A2347),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(Icons.favorite, size: 120, color: Colors.white),

                const SizedBox(height: 24),

                Text(
                  'BEULYNK',
                  style: GoogleFonts.manrope(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'App Icon Generator',
                  style: GoogleFonts.inter(fontSize: 20, color: Colors.white70),
                ),

                const SizedBox(height: 48),

                ElevatedButton(
                  onPressed: _isGenerating ? null : _generateIcons,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94560),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isGenerating
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Generate Icons',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),

                const SizedBox(height: 24),

                if (_status.isNotEmpty)
                  Text(
                    _status,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const IconGeneratorApp());
}
