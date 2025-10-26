# BEULYNK Logo System

This directory contains the BEULYNK logo system and app icon generation tools.

## Logo Widget (`beulynk_logo.dart`)

The `BeulynkLogo` widget provides a consistent, scalable logo system for the BEULYNK app.

### Features:
- **Responsive Design**: Automatically scales to fit any container
- **Multiple Variants**: White, dark, and accent color versions
- **App Icon Support**: Special icon-only versions for app bars and small spaces
- **Customizable**: Size, colors, and text visibility can be customized

### Usage Examples:

```dart
// Full logo with text
BeulynkLogoVariants.white

// Just the heart icon
BeulynkLogoVariants.appIconWhite

// Custom size and colors
BeulynkLogo(
  size: 100,
  heartColor: Colors.red,
  textColor: Colors.blue,
)

// Icon only
BeulynkLogo.icon(
  size: 32,
  heartColor: Colors.white,
)
```

### Predefined Variants:

- `BeulynkLogoVariants.white` - White logo for dark backgrounds
- `BeulynkLogoVariants.dark` - Dark logo for light backgrounds  
- `BeulynkLogoVariants.accent` - Accent color logo
- `BeulynkLogoVariants.appIconWhite` - White heart icon for app bars
- `BeulynkLogoVariants.appIconDark` - Dark heart icon for light app bars
- `BeulynkLogoVariants.appIconAccent` - Accent color heart icon

## App Icon Generator (`icon_generator.dart`)

A Flutter app that generates app icons for different platforms.

### Generated Icon Sizes:
- 16x16, 24x24, 32x32, 48x48, 64x64
- 96x96, 128x128, 192x192, 256x256, 512x512

### How to Use:
1. Run the icon generator: `flutter run lib/tools/icon_generator.dart`
2. Click "Generate Icons" button
3. Icons will be saved to `assets/images/` directory

### Icon Design:
- **Background**: Dark navy blue (`#1A2347`)
- **Heart**: White heart icon
- **Shape**: Clean, minimalist design matching the splash screen

## Integration

The logo system is already integrated into:
- ✅ Splash Screen
- ✅ Landing Page (AppBar and Hero section)
- ✅ Sign-In Page
- ✅ Sign-Up Page

## File Structure

```
lib/
├── widgets/
│   └── beulynk_logo.dart          # Main logo widget
├── tools/
│   └── icon_generator.dart        # App icon generator
└── assets/
    └── images/                    # Generated app icons
        ├── beulynk_icon_16x16.png
        ├── beulynk_icon_24x24.png
        ├── beulynk_icon_32x32.png
        └── ... (other sizes)
```

## Design Principles

1. **Consistency**: Same logo across all screens and platforms
2. **Scalability**: Works at any size without quality loss
3. **Accessibility**: High contrast white on dark background
4. **Minimalism**: Clean, simple design matching the app aesthetic
5. **Brand Recognition**: Distinctive heart icon with BEULYNK text
