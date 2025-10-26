# BEULYNK Design System & Component Guide

## Overview
This document describes the complete design system for the BEULYNK Flutter application, including all reusable components, styling guidelines, and usage instructions.

## Color Palette

### Primary Colors
- **Primary Red**: `Color(0xFFE94560)` - Main brand color for CTAs and accents
- **Dark Navy**: `Color(0xFF1A1A2E)` - Primary background
- **Medium Navy**: `Color(0xFF16213E)` - Secondary background
- **Deep Blue**: `Color(0xFF0F3460)` - Tertiary background

### Gradient Combinations
```dart
// Primary Background Gradient
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
    Color(0xFF0F3460).withOpacity(0.9),
  ],
)

// Primary Button Gradient
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFE94560),
    Color(0xFFD63447),
  ],
)
```

## Typography

### Font Families
- **Headings/Titles**: Manrope (via Google Fonts)
- **Body Text**: Inter (via Google Fonts)

### Font Sizes (Responsive with flutter_screenutil)
- **Hero Title**: 32-36.sp
- **Section Title**: 24-28.sp
- **Card Title**: 18-20.sp
- **Body Text**: 14-15.sp
- **Small Text**: 12-13.sp

### Font Weights
- **Bold**: FontWeight.bold (700)
- **Semi-Bold**: FontWeight.w600 (600)
- **Medium**: FontWeight.w500 (500)
- **Regular**: FontWeight.w400 (400)

## Reusable Components

### 1. HeroSectionWidget
**Location**: `lib/widgets/hero_section_widget.dart`

**Purpose**: Consistent page header with title, subtitle, and optional icon.

**Usage**:
```dart
HeroSectionWidget(
  title: 'About BEULYNK',
  subtitle: 'Unity through connection',
  icon: Icons.favorite,
  minHeight: 280.h,
)
```

**Parameters**:
- `title` (required): Main heading text
- `subtitle` (optional): Descriptive text below title
- `icon` (optional): Icon to display above title
- `minHeight` (optional): Minimum container height
- `gradientColors` (optional): Custom gradient colors

### 2. CustomFooter
**Location**: `lib/widgets/custom_footer.dart`

**Purpose**: Unified footer with branding, navigation links, and social media icons.

**Usage**:
```dart
const CustomFooter()
```

**Features**:
- App logo and name
- Tagline
- Quick navigation links (Home, About, How It Works, Contact)
- Social media icons (Facebook, Twitter, Instagram, LinkedIn)
- Copyright notice
- Fully responsive with flutter_screenutil

### 3. PrimaryButton
**Location**: `lib/widgets/custom_buttons.dart`

**Purpose**: Main call-to-action button with loading state.

**Usage**:
```dart
PrimaryButton(
  text: 'Get Started',
  onPressed: () { /* action */ },
  isLoading: false,
  width: double.infinity,
  icon: Icons.arrow_forward,
)
```

**Parameters**:
- `text` (required): Button label
- `onPressed` (required): Callback function
- `isLoading` (optional): Shows loading spinner
- `width` (optional): Button width
- `icon` (optional): Leading icon

### 4. SecondaryButton
**Location**: `lib/widgets/custom_buttons.dart`

**Purpose**: Outlined button for secondary actions.

**Usage**:
```dart
SecondaryButton(
  text: 'Learn More',
  onPressed: () { /* action */ },
  icon: Icons.info_outline,
)
```

### 5. CustomTextField
**Location**: `lib/widgets/custom_text_field.dart`

**Purpose**: Styled text input field with validation.

**Usage**:
```dart
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
    return null;
  },
)
```

**Parameters**:
- `controller` (required): TextEditingController
- `label` (required): Field label
- `hint` (optional): Placeholder text
- `prefixIcon` (optional): Leading icon
- `obscureText` (optional): For password fields
- `keyboardType` (optional): Input type
- `validator` (optional): Validation function
- `maxLines` (optional): Number of lines
- `suffixIcon` (optional): Trailing widget

### 6. CustomTextButton
**Location**: `lib/widgets/custom_buttons.dart`

**Purpose**: Text-only button for links and tertiary actions.

**Usage**:
```dart
CustomTextButton(
  text: 'Forgot Password?',
  onPressed: () { /* action */ },
  color: Color(0xFFE94560),
)
```

## Screen Layouts

### Standard Screen Structure
```dart
BeulynkLayout(
  title: 'Screen Name',
  body: Container(
    decoration: BoxDecoration(
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
            HeroSectionWidget(/* ... */),
            // Page content
            // ...
          ],
        ),
      ),
    ),
  ),
)
```

### Authentication Screen Structure
```dart
Scaffold(
  backgroundColor: Color(0xFF1A1A2E),
  body: ScrollConfiguration(
    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
    child: SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          _buildForm(),
          const CustomFooter(),
        ],
      ),
    ),
  ),
)
```

## Spacing Guidelines (with flutter_screenutil)

### Vertical Spacing
- **Extra Large**: 40-48.h (between major sections)
- **Large**: 24-32.h (between section elements)
- **Medium**: 16-20.h (between form fields)
- **Small**: 8-12.h (between related items)

### Horizontal Spacing
- **Page Margins**: 24.w
- **Card Padding**: 20-32.w
- **Button Padding**: 40.w horizontal, 18.h vertical

### Border Radius
- **Large Cards**: 20-24.r
- **Buttons**: 30.r
- **Input Fields**: 16.r
- **Small Cards**: 12-16.r

## Animation Guidelines

### Fade In
```dart
.animate().fadeIn(duration: 600.ms)
```

### Slide In
```dart
.animate().slideY(begin: -0.2, end: 0)
.animate().slideX(begin: -0.1, end: 0)
```

### Scale
```dart
.animate().scale()
```

### Delayed Animations
```dart
.animate().fadeIn(delay: 400.ms, duration: 600.ms)
```

## Responsive Design

### Using flutter_screenutil
All dimensions should use responsive units:
- Width: `.w` (e.g., `24.w`)
- Height: `.h` (e.g., `40.h`)
- Font Size: `.sp` (e.g., `16.sp`)
- Radius: `.r` (e.g., `20.r`)

### Screen Size Breakpoints
```dart
final isMobile = MediaQuery.of(context).size.width < 600;
final isTablet = MediaQuery.of(context).size.width >= 600 && 
                 MediaQuery.of(context).size.width < 1024;
final isDesktop = MediaQuery.of(context).size.width >= 1024;
```

### Adaptive Layouts
```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      return MobileLayout();
    } else {
      return DesktopLayout();
    }
  },
)
```

## Component Styling Patterns

### Card Container
```dart
Container(
  padding: EdgeInsets.all(24.w),
  decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(20.r),
    border: Border.all(
      color: Colors.white.withOpacity(0.1),
      width: 1,
    ),
  ),
  child: /* content */,
)
```

### Accent Card
```dart
Container(
  padding: EdgeInsets.all(24.w),
  decoration: BoxDecoration(
    color: Color(0xFFE94560).withOpacity(0.1),
    borderRadius: BorderRadius.circular(20.r),
    border: Border.all(
      color: Color(0xFFE94560).withOpacity(0.3),
      width: 2,
    ),
  ),
  child: /* content */,
)
```

### Gradient Card
```dart
Container(
  padding: EdgeInsets.all(32.w),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFE94560),
        Color(0xFFD63447),
      ],
    ),
    borderRadius: BorderRadius.circular(20.r),
  ),
  child: /* content */,
)
```

## Implementation Checklist

### For New Screens
- [ ] Use `BeulynkLayout` or custom Scaffold with consistent background
- [ ] Add `HeroSectionWidget` at the top
- [ ] Apply responsive sizing with `.w`, `.h`, `.sp`, `.r`
- [ ] Use reusable components (buttons, text fields)
- [ ] Add `CustomFooter` at the bottom
- [ ] Implement fade-in animations
- [ ] Test on both Android and Chrome
- [ ] Remove scrollbars with `ScrollConfiguration`
- [ ] Ensure proper SafeArea usage

### For Forms
- [ ] Use `CustomTextField` for all inputs
- [ ] Use `PrimaryButton` for submit actions
- [ ] Use `CustomTextButton` for links
- [ ] Add form validation
- [ ] Implement loading states
- [ ] Show success/error messages with SnackBar

## File Structure

```
lib/
├── screens/
│   ├── landing_page.dart
│   ├── about_page.dart
│   ├── how_it_works_page.dart
│   ├── contact_page.dart
│   ├── testimonials_page.dart
│   ├── signin_page.dart
│   ├── signup_page.dart
│   └── forgot_password_page.dart
├── widgets/
│   ├── beulynk_layout.dart
│   ├── beulynk_logo.dart
│   ├── hero_section_widget.dart
│   ├── custom_footer.dart
│   ├── custom_buttons.dart
│   └── custom_text_field.dart
├── services/
│   └── api_service.dart
└── config/
    └── api_config.dart
```

## Best Practices

1. **Always use responsive units** (`.w`, `.h`, `.sp`, `.r`)
2. **Maintain consistent spacing** following the guidelines
3. **Reuse components** instead of creating duplicates
4. **Keep color palette consistent** across all screens
5. **Test on multiple devices** (Android, iOS, Web)
6. **Use meaningful animations** sparingly
7. **Ensure accessibility** with proper contrast and font sizes
8. **Optimize images** and assets for performance
9. **Follow Flutter best practices** for state management
10. **Document custom components** for team collaboration

## Support

For questions or issues with the design system, refer to:
- Flutter documentation: https://flutter.dev/docs
- flutter_screenutil: https://pub.dev/packages/flutter_screenutil
- Google Fonts: https://pub.dev/packages/google_fonts

