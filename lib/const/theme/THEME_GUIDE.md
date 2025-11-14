# 🎨 Virtual Try-On App - Theme Guide

## Neutral Base + Peach Accent Color Palette

Premium, sophisticated palette with cool-neutral surfaces and warm peach accents.

**Design Philosophy**: Peach is used ONLY for highlights, never for backgrounds. All large surfaces use cool-neutral premium tones for a high-end fashion tech look.

---

## 🌈 Core Color Palette

### LIGHT MODE - Neutral Base

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| **Background** | `#F7F6F4` | Main background |
| **Surface** | `#F0EEEB` | Cards, containers |
| **SurfaceVariant** | `#E6E3E0` | Inputs, chips |
| **Border** | `#D7D3D0` | Dividers, borders |
| **TextPrimary** | `#2E2B2B` | Primary text |
| **TextSecondary** | `#6B6565` | Secondary text |
| **IconNeutral** | `#7A7472` | Neutral icons |
| **Shadow** | `rgba(0,0,0,0.06)` | Shadows |

### ACCENTS - Peach (Highlights Only)

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| **PrimaryPeach** | `#E8A98F` | Primary accent |
| **PrimarySoft** | `#F3D4C6` | Soft accent |
| **PrimaryDark** | `#C9896F` | Dark accent |

### DARK MODE - Cool Neutral

| Color Name | Hex Code | Usage |
|------------|----------|-------|
| **DarkBackground** | `#121214` | Main background |
| **DarkSurface** | `#1C1C1F` | Cards, containers |
| **DarkSurfaceVariant** | `#252529` | Inputs, chips |
| **DarkBorder** | `#3A3A40` | Dividers, borders |
| **DarkTextPrimary** | `#F5F4F3` | Primary text |
| **DarkTextSecondary** | `#C7C7C9` | Secondary text |

**Note**: Accent colors stay the same in dark mode, but slightly desaturated or opacity-adjusted when needed.

---

## 🌞 Light Theme Mapping

```dart
// Color Scheme
primary:        PrimaryPeach   (#E8A98F)
secondary:      PrimarySoft    (#F3D4C6)
background:     Background     (#F7F6F4)
surface:        Surface        (#F0EEEB)
surfaceVariant: SurfaceVariant (#E6E3E0)
onSurface:      TextPrimary    (#2E2B2B)
outline:        Border         (#D7D3D0)
```

### Component Rules

✅ **Peach is used ONLY in**:
- Filled buttons
- Active toggles
- Active tabs / segmented controls
- Primary icons
- Progress indicators
- Hero elements

❌ **Do NOT use peach in**:
- Large surfaces
- Card backgrounds
- Scaffold backgrounds
- Surface variants

### Component Styling

#### Buttons
- **FilledButton**: PrimaryPeach background, white text
- **OutlinedButton**: Neutral border, TextPrimary text
- **TextButton**: PrimaryPeach text
- **GradientButton**: PeachGradient (for CTAs ONLY)

#### Cards & Surfaces
- **Background**: Surface (#F0EEEB) - NEVER peach
- **Border**: Border (#D7D3D0)
- **Shadow**: Shadow (rgba(0,0,0,0.06))

#### Text
- **Primary**: TextPrimary (#2E2B2B)
- **Secondary**: TextSecondary (#6B6565)

#### Icons
- **Neutral**: IconNeutral (#7A7472)
- **Primary Actions**: PrimaryPeach (#E8A98F)

---

## 🌙 Dark Theme Mapping

```dart
// Color Scheme
primary:        PrimaryPeach      (#E8A98F)
secondary:      PrimarySoft       (#F3D4C6)
background:     DarkBackground    (#121214)
surface:        DarkSurface       (#1C1C1F)
surfaceVariant: DarkSurfaceVariant (#252529)
onSurface:      DarkTextPrimary   (#F5F4F3)
outline:        DarkBorder        (#3A3A40)
```

### Dark Mode Rules

✅ **Requirements**:
- No warm browns
- No peach backgrounds
- Dark surfaces must be cool-neutral gray / charcoal
- Peach appears only as small accents

### Component Styling

#### Buttons
- **FilledButton**: PrimaryPeach background, white text
- **OutlinedButton**: DarkBorder border, DarkTextPrimary text
- **IconButton**: PrimarySoft with 85% opacity

#### Cards & Surfaces
- **Background**: DarkSurface (#1C1C1F) - NEVER peach
- **Border**: DarkBorder (#3A3A40)
- **Shadow**: DarkShadow

#### Text
- **Primary**: DarkTextPrimary (#F5F4F3)
- **Secondary**: DarkTextSecondary (#C7C7C9)

---

## 🎨 Gradient Usage (PeachGradient)

The PeachGradient is used **ONLY** for:
- Main "Generate" button
- Onboarding "Continue" button
- Selected chips or filters

```dart
// Gradient Definition
PeachGradient = [
  Color(0xFFE8A98F),   // Primary peach
  Color(0xFFF3D4C6),   // Soft peach
]
```

### Using Gradient Components

```dart
// Gradient Button (CTA only)
GradientButton(
  text: 'Generate',
  icon: Icons.auto_awesome,
  onPressed: () { },
)

// Gradient Icon Button
GradientIconButton(
  icon: Icons.camera_alt,
  onPressed: () { },
)

// Gradient Chip (selected state)
GradientChip(
  label: 'Summer',
  isSelected: true,
  onTap: () { },
)
```

---

## 🧭 Component-Level Rules

### Segmented Control
- **Background**: SurfaceVariant
- **Active Indicator**: PrimaryPeach
- **Inactive text**: TextSecondary
- **Active text**: TextPrimary

### Cards
- **Background**: Surface (NOT peach)
- **Border**: Border
- **Shadow**: Shadow

### Switch
- **Active thumb**: White
- **Active track**: PrimaryPeach
- **Inactive track**: Border

### AppBar
- **Background**: Background
- **Icons**: IconNeutral
- **Title**: TextPrimary

### Chips
- **Background**: SurfaceVariant (NOT peach)
- **Active background**: PrimarySoft
- **Active border**: PrimaryPeach

---

## 🔧 Accessing Colors in Code

### Standard Colors (via Theme)

```dart
// Primary colors
Theme.of(context).colorScheme.primary        // PrimaryPeach
Theme.of(context).colorScheme.secondary      // PrimarySoft
Theme.of(context).colorScheme.surface        // Surface / DarkSurface
Theme.of(context).colorScheme.background     // Background / DarkBackground

// Text colors
Theme.of(context).colorScheme.onSurface      // TextPrimary / DarkTextPrimary
Theme.of(context).colorScheme.onBackground   // TextPrimary / DarkTextPrimary

// Border
Theme.of(context).colorScheme.outline        // Border / DarkBorder
```

### Semantic Colors (via Extension)

```dart
// Access custom theme extension
final colors = context.appColors;

// Neutral surfaces
colors.background       // Background color
colors.surface          // Surface color
colors.surfaceVariant   // Surface variant
colors.border           // Border color

// Text
colors.textPrimary      // Primary text
colors.textSecondary    // Secondary text

// Peach accents
colors.primaryPeach     // Primary peach accent
colors.primarySoft      // Soft peach accent
colors.primaryDark      // Dark peach accent

// Icons
colors.iconNeutral      // Neutral icon color

// Gradients
colors.peachGradient    // Gradient object (CTA only)
colors.subtleGradient   // Subtle gradient

// Shadow
colors.shadow           // Shadow color
```

### Direct Color Access (AppColors)

```dart
import 'package:virtual_try_on/const/theme/app_colors.dart';

// Light mode
AppColors.background
AppColors.surface
AppColors.surfaceVariant
AppColors.border
AppColors.textPrimary
AppColors.textSecondary
AppColors.iconNeutral
AppColors.primaryPeach
AppColors.primarySoft
AppColors.primaryDark

// Dark mode
AppColors.darkBackground
AppColors.darkSurface
AppColors.darkSurfaceVariant
AppColors.darkBorder
AppColors.darkTextPrimary
AppColors.darkTextSecondary

// Gradients
AppColors.peachGradient  // List<Color>
```

---

## 🎯 Component Examples

### Card with Neutral Surface

```dart
Card(
  color: Theme.of(context).colorScheme.surface, // Neutral, NOT peach
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: BorderSide(
      color: Theme.of(context).colorScheme.outline,
    ),
  ),
  child: ...,
)
```

### Filled Button with Peach Accent

```dart
FilledButton(
  onPressed: () {},
  style: FilledButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.primary, // Peach
  ),
  child: Text('Continue'),
)
```

### Gradient CTA Button

```dart
GradientButton(
  text: 'Generate',
  icon: Icons.auto_awesome,
  onPressed: () { },
) // Only for primary CTAs
```

---

## 🖼️ Screen-Specific Guidelines

### Onboarding
- Background → Background (neutral)
- Cards → Surface (neutral, NOT peach)
- Active card border → PrimaryPeach
- Continue button → PeachGradient

### Try-On Screen
- Product thumbnails → Surface (neutral)
- Selected item border → PrimaryPeach (2px)
- Generate button → PeachGradient
- Icons → IconNeutral / PrimaryPeach (active)

### Result Screen
- CTA buttons → PrimaryPeach or PeachGradient
- Info cards → Surface (neutral)
- Icons → PrimaryPeach

### Gallery
- Grid cards → Surface (neutral)
- Labels → TextPrimary / DarkTextPrimary
- Filters → GradientChip when selected

---

## ✅ Best Practices

1. **Never hardcode colors** in widgets
2. **Always use Theme.of(context)** for standard colors
3. **Use context.appColors** for semantic access
4. **Never use peach for large surfaces**
5. **Use GradientButton ONLY for primary CTAs**
6. **Respect the accent usage rules**
7. **Test both light and dark themes**

---

## 🚀 Theme Switching

The app supports smooth theme transitions with 500ms animation:

```dart
// Switch to light theme
context.read<ThemeCubit>().setLightTheme();

// Switch to dark theme
context.read<ThemeCubit>().setDarkTheme();

// Use system theme
context.read<ThemeCubit>().setSystemTheme();
```

---

## 📦 Files Structure

```
lib/const/theme/
├── app_colors.dart           # Color palette definitions
├── theme_extensions.dart     # Custom theme extensions
├── light_theme.dart          # Light theme configuration
├── dark_theme.dart           # Dark theme configuration
└── THEME_GUIDE.md           # This guide

lib/presentation/common/widgets/
├── gradient_button.dart      # Gradient button components
└── theme_toggle.dart         # Theme switcher widget

lib/application/settings/bloc/
└── theme_cubit.dart          # Theme state management
```

---

## 🎨 Design Principles

- **Premium**: Cool-neutral surfaces convey sophistication
- **Modern**: Clean, minimal design with subtle accents
- **Sophisticated**: Peach used strategically as highlight
- **High Contrast**: Strong text contrast for readability
- **Fashion Tech**: Premium palette suitable for fashion industry
- **Cool-Neutral Dark**: No warm browns in dark mode

---

**Last Updated**: November 2025
**Palette Version**: 4.0 (Neutral Base + Peach Accent)
