# Activity Manager

A Flutter application for managing daily activity lists. Helps you add, display, and filter activities by time easily.

## Key Features

- 📝 **Add Activities**: Add new activities with name, description, and time
- 📋 **Display List**: Show activity list sorted by time
- 🔍 **Filter Data**: Show only activities after 18:00
- ✅ **Data Validation**: Validate input data accuracy
- 🗑️ **Delete Activities**: Remove unwanted activities

## System Requirements

- **Flutter**: 3.10.0 or higher
- **Dart**: 3.0.0 or higher
- **Android**: API level 21 or higher
- **iOS**: 11.0 or higher

## Installation and Running the App

### 1. Clone the project

```bash
git clone <repository-url>
cd activity_manager
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
# Run on emulator/simulator or real device
flutter run

# Or run in debug mode
flutter run --debug

# Run in release mode (for performance testing)
flutter run --release
```

### 4. Build APK for Android

```bash
# Build debug APK
flutter build apk --debug

# Build release APK
flutter build apk --release
```

The built APK will be in `build/app/outputs/flutter-apk/`

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── activity.dart           # Activity data model
├── providers/
│   └── activity_provider.dart  # State management with Provider
├── screens/
│   └── home_screen.dart        # Main screen
└── widgets/
    ├── activity_item.dart      # Widget for displaying activity list
    └── add_activity_dialog.dart # Dialog for adding activities
```

## Provider State Management

I chose **Provider** as the state management solution because:

### Advantages:

- **Easy to learn**: Not too steep learning curve
- **Suitable for small projects**: Not overly complex for apps with minimal state
- **Business logic separation**: Clear separation between UI and business logic
- **Good performance**: Selective rebuild helps UI update only changed parts
- **Community support**: Strong documentation and community

### Compared to other options:

- **vs setState**: Provider better handles global state and business logic separation
- **vs Riverpod**: Riverpod has more features but too complex for small projects like this
- **vs Bloc/Cubit**: Bloc pattern suits complex apps but has more boilerplate code

## Usage

1. **Add new activity**: Press the + button at bottom right
2. **Filter activities**: Press the 3-dot menu at top right and select "Show After 18:00"
3. **Delete activity**: Press the trash icon in the activity list
4. **View details**: Information is displayed in the activity card

## Testing

```bash
# Run all tests
flutter test

# Run tests in verbose mode
flutter test --verbose
```

## Build for Production

### Android APK

```bash
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
```

### Android App Bundle (for Google Play Store)

```bash
flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols
```

### iOS

```bash
flutter build ios --release
```

## License

MIT License - See LICENSE file for details

## Developer

Built with Flutter and Created by Thanakorn Thajan❤️

---

**Note**: This app is developed for testing and learning purposes. For actual commercial use, additional features like data persistence, data backup, and improved UX/UI should be added.
