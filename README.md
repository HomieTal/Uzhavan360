# Uzhavan 360

Uzhavan 360 is a Flutter-based smart farming companion designed to help farmers manage crop health, irrigation, weather, storage, buyers, and government schemes from one place. The app supports English and Tamil, includes a demo OTP-based authentication flow, and uses mock data to showcase the full experience without needing a backend.

## Overview

The app is organized as a farm operations dashboard. After signing in, users can explore modules for soil testing, smart seeding, auto irrigation, pest detection, weather monitoring, storage monitoring, buyer matching, and government schemes. The home dashboard also surfaces alerts, summaries, and quick actions so the most important farming tasks stay visible.

This repository currently focuses on the UI, navigation, state management, localization, and demo data flow. It is a strong foundation for connecting real APIs, sensors, and external services later.

## Key Features

- Mobile-number and OTP sign-in flow with demo credentials for testing.
- English and Tamil localization support.
- Light and dark theme switching.
- Farmer profile management.
- Dashboard with quick farming modules and alerts.
- Soil testing and crop recommendation flow.
- Smart seeding recommendations based on soil data.
- Auto irrigation controls with pump, moisture, and GSM call toggles.
- Pest detection and history views.
- Weather summary and 7-day forecast.
- Storage facility discovery.
- Buyer matching for produce sales.
- Government schemes and subsidy information.
- Mock data service for offline UI exploration.

## Tech Stack

- Flutter
- Dart
- Provider for app state management
- Flutter localization packages
- Material Design widgets

## Demo Authentication

The current authentication flow is intentionally mocked so the interface can be explored without a server.

- Demo mobile number: `9876543210`
- Demo OTP: `123456`

You can also use the UI flow to send and verify an OTP for the number you enter during the session.

## Supported Platforms

The project includes the standard Flutter platform folders for:

- Android
- iOS
- Web
- Windows
- macOS
- Linux

## Project Structure

```text
lib/
	app.dart                  # App shell, localization, theme, and routing
	main.dart                 # App entry point
	core/
		localization/           # Translation and locale services
		navigation/             # Route generation
		state/                  # App-wide state controller
		theme/                  # Light and dark themes
		widgets/                # Shared UI widgets
	data/
		mock_data_service.dart   # Demo data used across the app
	features/
		auth/                    # Login and signup screens
		dashboard/               # Home dashboard
		home/                    # Main shell and navigation
		market/                  # Market and buyer flow
		notifications/           # Alerts and updates
		profile/                 # Farmer profile screen
		modules/                 # Farming feature modules
	models/                    # App data models

assets/
	i18n/                      # English and Tamil translation files
	images/                    # App images and branding assets
```

## Getting Started

### Prerequisites

- Flutter SDK installed and configured
- Dart SDK bundled with Flutter
- An Android emulator, iOS simulator, desktop target, or a connected device

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

### Run on a Specific Platform

```bash
flutter run -d android
flutter run -d ios
flutter run -d chrome
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

## Build Commands

```bash
flutter build apk
flutter build ios
flutter build web
flutter build windows
flutter build macos
flutter build linux
```

## Localization

The app loads translations from `assets/i18n/en.json` and `assets/i18n/ta.json`.

Language switching is handled through the app state controller, and the selected locale is applied at the MaterialApp level. Any new user-facing text should be added to both translation files to keep the English and Tamil experiences aligned.

## Theme and State

App-wide state is managed with Provider through `AppStateController`. The controller handles:

- Current locale
- Theme mode
- Authentication state
- Dashboard navigation index
- Demo profile and farming data
- Soil report and crop recommendation state
- Irrigation controls

## Routing

Feature screens are routed through the central route generator in the core navigation layer. The current named routes cover:

- Soil testing
- Smart seeding
- Auto irrigation
- Pest detection
- Weather monitoring
- Storage monitoring
- Buyer match
- Government schemes

## Mock Data

This project uses mocked data for profile information, weather, storage, buyers, notifications, pest history, and scheme listings. That keeps the UI functional while backend services are still being planned or integrated.

## Customization Notes

If you want to evolve this app into a production system, the most likely next steps are:

- Replace demo OTP authentication with a real auth provider.
- Connect weather, market, and scheme content to live APIs.
- Integrate soil and pest analysis services.
- Persist profile and settings data locally or in the cloud.
- Add push notifications for farm alerts.

## Assets

The app expects branding and localization assets under the following paths:

- `assets/images/`
- `assets/i18n/`

The launcher icon is configured in `pubspec.yaml` to use `assets/images/Uzhavann-logo.jpg`.

## Testing

```bash
flutter test
```

## Troubleshooting

- If assets are not loading, run `flutter pub get` again and confirm the paths in `pubspec.yaml`.
- If localization text does not update, make sure the same key exists in both JSON files.
- If a platform build fails, confirm that the Flutter SDK and the target platform toolchain are installed correctly.

## License

This project is currently distributed under the terms listed in the repository `LICENSE` file.
