--- alwaysApply: true ---

# Virtual Try-On App - Cursor Rules

This project defines the architectural, UI, and technical standards for the **AI Virtual Try-On App**. The app enables users to upload their photo and virtually try on garments or accessories (up to 2 items) using AI. The app also includes a catalog feature where users can choose clothing from real brands.

---

## 1. Project Overview

**Core Stack:**

* **Flutter SDK:** 3.8.1+
* **Architecture:** Clean Architecture + Feature-Based
* **State Management:** Bloc / HydratedBloc
* **Navigation:** AutoRoute (Cupertino-style transitions)
* **Dependency Injection:** GetIt + Injectable
* **Data Models:** Freezed + JsonSerializable
* **Networking:** Dio + Retrofit
* **Localization:** intl / ARB (8–9 languages)
* **Theming:** Light and Dark modes with persistent ThemeMode

**Key Features:**

* Upload and try-on garments or accessories (max 2).
* Choose from cataloged brand items (Zara, COS, Miu Miu, etc.).
* View and manage generated results in Gallery.
* Modern onboarding flow with hero animations.
* Smooth transitions, micro-animations, and haptics.

---

## 2. Folder Structure

```plaintext
lib/
  application/                 # Bloc/Cubit Layer (Feature-Based)
    try_on/
      bloc/
    catalog/
      bloc/
    gallery/
      bloc/
    profile/
      bloc/
    settings/
      bloc/
  core/                        # Core Utilities
    constants/                 # Padding, Radius, Durations
    extensions/                # BuildContext, String, Theme extensions
    router/                    # AutoRoute config
    utils/                     # Logger, Haptics, Debouncer, etc.
  const/                       # Global constants, themes, typography
  l10n/                        # Localization (intl ARB files)
  presentation/
    pages/
      onboarding/
        widgets/
        onboarding_screen.dart
      try_on/
        widgets/
        try_on_screen.dart
      result/
        widgets/
        result_screen.dart
      gallery/
        widgets/
        gallery_screen.dart
      profile/
        widgets/
        profile_screen.dart
      settings/
        widgets/
        settings_screen.dart
    common/
      widgets/                 # Reusable UI widgets (Buttons, Cards)
      animations/              # Common animated components
  repository/
    model/                     # Freezed Models
    service/                   # Retrofit + Dio Services
  gen/                         # Generated files (injectable, router, etc.)
```

---

## 3. State Management Rules

Each feature has its own Bloc folder. All states/events are modeled via **Freezed sealed classes**.

Example:

```dart
@freezed
sealed class TryOnState with _$TryOnState {
  const factory TryOnState.initial() = _Initial;
  const factory TryOnState.loading() = _Loading;
  const factory TryOnState.success(TryOnResult result) = _Success;
  const factory TryOnState.error(String message) = _Error;
}
```

### Bloc Best Practices

* Use `@injectable` constructors for DI.
* Wrap all async actions in `try/catch`.
* Check `if (isClosed)` before emitting.
* Persist key user data (language, theme, last used image) with HydratedBloc.
* Group async error handling in a shared base bloc mixin.

---

## 4. Navigation

* Configured in `core/router/app_router.dart`.
* Use `@AutoRouterConfig()`.
* Default transition: `RouteType.cupertino()`.

**Route naming convention:**

```
OnboardingRoute
TryOnRoute
ResultRoute
GalleryRoute
ProfileRoute
SettingsRoute
```

* Tabs are implemented with nested routers.
* Guard protected routes for premium or login features when needed.

---

## 5. Localization

**Supported Languages (min 8–9):**

* tr, en, de, fr, es, it, pt, ru, (ar or nl optional)

**Localization Rules:**

* All text in `.arb` files. No hardcoded strings.
* Keys in `snake_case`.
* Use via `context.l10` or `AppLocalizations.of(context)`.

```dart
Text(context.l10.onboarding_title);
```

* Use placeholders `{variable}`.
* Support runtime language switching from Settings.

---

## 6. Theming & Styling

### Theme Mode

* Both **Light** and **Dark** themes are required.
* Store user’s ThemeMode persistently.

### Light Theme

* White/gray surface colors, soft shadows.
* Accent: soft pink/purple/blue gradient.

### Dark Theme

* Deep gray/black backgrounds (#0A0A0F ~ #101015).
* Surface: layered grays, accent pops.

### Design Language

* Rounded corners (20–28 radius typical)
* Shadows = `soft` (blur 15–25)
* Subtle glass/blur when needed (e.g., overlay panels)

### Text

* Font: San Francisco / Inter / or modern geometric sans.
* Typography accessible via `context.textTheme`.

---

## 7. UI Principles

### General

* All pages must use **const constructors** where possible.
* Never return widgets directly from functions; use components.
* Responsive layouts: media query or `LayoutBuilder` for dynamic sizing.

### Onboarding

* Hero image + background circle or color wheel (Stack layout).
* Horizontal style selector (rounded cards with shadow + active scale effect).
* Full-width “Continue” button (pill, elevated).
* Bottom row links: Terms & Privacy Policy.

### Try-On Screen

* Header: Gender selector (♀ ♂ icons).
* Segmented control tabs: **Custom / Catalog**.
* Product grid:

  * Rounded image cards (radius 16–24).
  * Locked content shows blurred overlay with lock icon.
  * Brand label + item name under image.
* Floating generate button.

### Processing Screen

* Progress text: “İşleniyor...37%”
* Centered large user photo.
* Bottom blurred info card with small image and text.
* Soft fade animations.

### Gallery

* Grid layout (2–3 columns).
* Cards show thumbnail + brand/category + date.
* Tap to open Result screen.

### Result Screen

* Large final image.
* Title: “Outfit’in hazır ✨”.
* Buttons: Download, Share, Try Again.
* Info section: brand, category, date.

---

## 8. Animations & Haptics

### Transitions

* Page transitions: Cupertino-style, soft ease-in-out.
* Hero animations for image continuity.
* Smooth fade-in for async-loaded content.

### Micro Animations

* Use `AnimatedContainer`, `AnimatedScale`, `AnimatedOpacity`.
* Tap states should slightly scale (1.0 → 1.05).
* Tab switch or button press triggers short `AnimatedSwitcher` transitions.

### Haptics

* Implement `core/utils/haptics.dart` service:

  ```dart
  Haptics.lightImpact();
  Haptics.mediumImpact();
  Haptics.selection();
  ```
* Primary actions: mediumImpact.
* Tab or segment change: selection.
* Success (AI result ready): lightImpact.

---

## 9. API Integration

### Wiro Virtual Try-On Model

* Endpoint: `/Run/wiro/Virtual Try-On`
* Params:

  * `human_image` (user photo)
  * `garment_images` (max 2)
  * `photography_style` (optional)

### Backend Guidelines

* Use `Dio` with interceptors for headers and auth.
* Retrofit interface under `repository/service/try_on_service.dart`.
* Map models via `Freezed`.

### Error Handling

* Catch all DioErrors.
* Convert server errors to user-friendly messages.
* Show fallback UI states.

---

## 10. Performance

* Use `CachedNetworkImage` for product/result images.
* Use `Shimmer` placeholders.
* Use Slivers for scrollable grids.
* Keep frame render <16ms.

---

## 11. Testing

* Use `bloc_test` for business logic.
* Use `flutter_test + mocktail` for widgets.
* Create `WidgetKeys` for important elements.

---

## 12. Code Review Checklist

* [ ] No lint warnings (dart analyze clean)
* [ ] All widgets `const` where possible
* [ ] Localization strings used via context.l10
* [ ] ThemeMode persistence tested
* [ ] Bloc structure correct (Feature-based)
* [ ] API models use Freezed & Retrofit
* [ ] No hardcoded text/colors
* [ ] Haptics integrated in key UI flows
* [ ] Animations smooth and non-blocking
* [ ] build_runner completes with no conflicts
* [ ] Tests exist for Bloc + Service layers

---

## 13. UX Enhancement Notes

* Keep transitions subtle but satisfying.
* Use bounce easing for chips/cards.
* Allow instant retry on AI result screen.
* In dark mode, emphasize gradient highlights (e.g., pink → violet overlay).
* Provide skeletons during AI wait states.

---

**This ruleset must be applied globally for all Cursor-based refactors, feature additions, and new page implementations in the Virtual Try-On project.**
