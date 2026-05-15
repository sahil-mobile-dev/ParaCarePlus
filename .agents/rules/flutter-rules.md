---
trigger: always_on
---

# Flutter Project Engineering Guidelines

## Tech Stack

This project follows a modern scalable Flutter architecture using:

* Flutter
* Riverpod
* GoRouter
* Dio
* MVVM Architecture
* Clean and Consistent Design System

---

# FVM Rules

## Flutter Version Management

This project MUST use:

```txt
FVM (Flutter Version Management)
```

Reason:

* Consistent Flutter SDK across team
* Prevent environment mismatch
* Stable builds
* Easier CI/CD management
* Version isolation per project

---

## Mandatory FVM Rules

### Always Run Flutter Commands Using FVM

Correct:

```bash
fvm flutter run
fvm flutter pub get
fvm flutter build apk
```

Avoid:

```bash
flutter run
flutter pub get
```

---

## Recommended Flutter Version Strategy

* Lock project to a stable Flutter version
* Avoid upgrading Flutter frequently
* Test packages before upgrades
* Maintain consistent SDK in all environments

---

## Recommended Setup

```bash
fvm install stable
fvm use stable
```

---

## VS Code Configuration

Add:

```json
{
  "dart.flutterSdkPath": ".fvm/flutter_sdk"
}
```

inside:

```txt
.vscode/settings.json
```

---

# Core Development Principles

## 1. Consistency Over Creativity

The entire application must maintain:

* Same typography
* Same spacing
* Same color system
* Same radius system
* Same button behavior
* Same navigation pattern
* Same animation behavior
* Same component styling

Consistency creates a premium user experience.

---

# Project Architecture

## Architecture Pattern

The application follows:

```txt
MVVM (Model View ViewModel)
```

Structure:

```txt
Feature
 ├── model
 ├── view
 ├── view_model
 ├── repository
 └── service
```

Example:

```txt
features/
 └── auth/
      ├── model/
      ├── view/
      ├── view_model/
      ├── repository/
      └── service/
```

---

# Folder Structure

```txt
lib/
│
├── core/
│   ├── constants/
│   ├── extensions/
│   ├── network/
│   ├── services/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── profile/
│   └── settings/
│
├── localization/
├── routes/
└── main.dart
```

---

# Naming Conventions

## File Naming

Use:

```txt
snake_case
```

Examples:

```txt
login_screen.dart
profile_view_model.dart
app_button.dart
```

---

## Class Naming

Use:

```txt
PascalCase
```

Examples:

```txt
LoginScreen
AuthRepository
ProfileViewModel
```

---

## Variable Naming

Use:

```txt
camelCase
```

Examples:

```txt
userName
isLoading
selectedIndex
```

---

# State Management Rules

## State Management

The project uses:

```txt
Riverpod
```

Preferred approach:

```txt
AsyncNotifier + Riverpod Generator
```

---

## Riverpod Rules

### Allowed

* State handling
* Business logic
* API orchestration
* Dependency injection

### Not Allowed

* API calls directly inside UI
* Business logic inside widgets
* Excessive use of setState

---

# MVVM Responsibilities

## View

Responsible for:

* Rendering UI
* Handling user interaction
* Listening to state changes

Should NOT:

* Call APIs directly
* Contain business logic

---

## ViewModel

Responsible for:

* Managing state
* Handling business logic
* Calling repositories
* Managing UI events

---

## Repository

Responsible for:

* Data abstraction
* Managing data sources
* Communicating with services

---

## Service

Responsible for:

* API calls
* External integrations
* Network communication

---

# Routing Rules

## Routing Package

The project uses:

```txt
GoRouter
```

---

## Route Structure

```txt
routes/
 ├── app_router.dart
 ├── route_names.dart
 └── route_paths.dart
```

---

## Routing Rules

### Use Named Routes

Correct:

```dart
context.pushNamed(RouteNames.profile);
```

Avoid:

```dart
context.push('/profile');
```

---

## Navigation Rules

* No inline route strings
* Centralized route management
* Authentication guards handled globally
* Avoid duplicate navigation logic

---

# Network Layer Rules

## Networking Package

The project uses:

```txt
Dio
```

---

## Network Structure

```txt
core/network/
 ├── dio_client.dart
 ├── api_endpoints.dart
 ├── interceptors/
 ├── exceptions/
 └── network_info.dart
```

---

## Dio Rules

### Mandatory Interceptors

#### Request Interceptor

* Inject token
* Add headers
* Request logging

#### Response Interceptor

* Parse response
* Response logging

#### Error Interceptor

* Handle session expiration
* Handle retries
* Global error handling

---

## API Rules

* No direct API call from UI
* Use repository pattern
* Standardized API response handling
* Proper exception handling
* Use strongly typed models

---

# Theme & Styling Rules

## Centralized Theme System

```txt
core/theme/
 ├── app_colors.dart
 ├── app_dimensions.dart
 ├── app_radius.dart
 ├── app_shadows.dart
 ├── app_spacing.dart
 ├── app_text_styles.dart
 └── app_theme.dart
```

---

## Styling Rules

### Never Use Inline Styling

Avoid:

```dart
TextStyle(fontSize: 17, color: Colors.red)
```

Use:

```dart
AppTextStyles.bodyMedium
```

---

## Color Rules

Use semantic colors.

Correct:

```dart
AppColors.primary
AppColors.error
AppColors.success
```

Avoid:

```dart
Colors.red
Colors.blue
```

---

## Typography Rules

Use predefined text styles.

Examples:

```dart
AppTextStyles.titleLarge
AppTextStyles.bodyMedium
AppTextStyles.labelSmall
```

---

## Spacing Rules

Use consistent spacing scale.

Allowed spacing values:

```txt
4
8
12
16
20
24
32
40
48
```

Correct:

```dart
SizedBox(height: AppSpacing.md)
```

Avoid:

```dart
SizedBox(height: 17)
```

---

# Widget Rules

## Widget Reusability

Reusable widgets must be created for:

* Buttons
* TextFields
* AppBars
* Dialogs
* Loaders
* Empty States
* Bottom Sheets
* Cards
* Network Images

---

## Common Widgets Structure

```txt
core/widgets/
 ├── app_button.dart
 ├── app_textfield.dart
 ├── app_loader.dart
 ├── app_dialog.dart
 ├── app_appbar.dart
 └── network_image_widget.dart
```

---

## Widget Splitting Rules

If a widget exceeds:

```txt
250–300 lines
```

It must be split into smaller reusable widgets.

---

# Screen Rules

## Single Responsibility

One screen should focus on one responsibility.

Avoid:

```txt
Massive dashboard_screen.dart
```

Prefer:

```txt
dashboard/
 ├── dashboard_screen.dart
 ├── widgets/
 │    ├── stats_card.dart
 │    ├── chart_widget.dart
 │    └── recent_orders.dart
```

---

# Model Rules

All models should contain:

* fromJson
* toJson
* copyWith

Recommended:

```txt
freezed
json_serializable
```

---

# State Rules

Every state should follow:

```txt
loading
success
empty
error
```

Avoid random state booleans.

---

# Performance Rules

## Mandatory Optimizations

* Use const widgets
* Lazy loading
* Pagination
* Proper controller disposal
* Debouncing search inputs
* Image caching
* Avoid unnecessary rebuilds

---

# Responsive Design Rules

## Mandatory Usage

* MediaQuery
* LayoutBuilder
* Flexible widgets
* Responsive spacing

---

## Avoid

* Hardcoded heights
* Fixed-width layouts
* Pixel-perfect assumptions

---

# Environment Rules

## Use Multiple Environments

```txt
.env.dev
.env.staging
.env.production
```

Separate:

* API URLs
* Firebase configurations
* App names
* Keys

---

# Linting Rules

Mandatory:

```yaml
flutter_lints
very_good_analysis
```

Rules:

* No analyzer warnings
* No unused imports
* Proper formatting required
* Consistent code style

---

# Git Rules

## Branch Naming

```txt
main
develop
feature/login
feature/profile
bugfix/payment
```

---

## Commit Naming

```txt
feat: added login api
fix: resolved splash issue
refactor: improved auth flow
```

---

# Pull Request Rules

* No direct push to main
* Minimum one review required
* Must pass analyzer
* No warnings allowed
* Keep PR focused and small

---

# Recommended Packages

| Purpose            | Package            |
| ------------------ | ------------------ |
| State Management   | flutter_riverpod   |
| Routing            | go_router          |
| Networking         | dio                |
| SVG                | flutter_svg        |
| Responsive         | flutter_screenutil |
| Model Generation   | freezed            |
| JSON Serialization | json_serializable  |
| Local Storage      | hive               |
| Logging            | logger             |

---

# Development Golden Rules

1. No business logic inside UI
2. Follow MVVM strictly
3. Maintain consistent theme system
4. Avoid hardcoded values
5. Create reusable components
6. Use centralized routing
7. Keep files readable and small
8. Use repository pattern for APIs
9. Write scalable and maintainable code
10. Focus on clean architecture and consistency

---