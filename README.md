# Memory Matching Flutter Game

## Project Overview

This is a **Memory Matching Flutter Game** developed as part of **COMP5450 Mobile Programming** at **Lakehead University**. The game challenges players to find matching pairs of animal images in a 4×5 grid layout, featuring smooth animations, responsive design, and an intuitive user interface.

### Key Features
- **Classic Memory Game**: Find all 10 matching pairs of animal cards
- **Beautiful UI**: Soft pastel color scheme with polished card designs
- **Smooth Animations**: 3D card flip animations with 600ms duration
- **Responsive Design**: Adaptive layout for phones and tablets
- **Score Tracking**: Real-time match counter in the app bar
- **Restart Functionality**: Easy game reset with premium button styling

## Project Structure

```
memory_match_game/
├── README.md                           # Project documentation
├── .gitignore                          # Git ignore configuration
├── pubspec.yaml                        # Flutter project configuration
├── pubspec.lock                        # Dependency lock file
├── analysis_options.yaml              # Dart analysis configuration
├── memory_match_game.iml               # IntelliJ module file
├── android/                            # Android platform files
├── ios/                               # iOS platform files (if configured)
├── web/                               # Web platform files (if configured)
├── windows/                           # Windows platform files (if configured)
├── build/                             # Build output (ignored by git)
├── .dart_tool/                        # Dart tools cache (ignored by git)
├── test/                              # Unit and widget tests
├── assets/
│   └── images/                        # Game asset images
│       ├── 1.jpg                      # Animal image 1
│       ├── 2.jpg                      # Animal image 2
│       ├── 3.jpg                      # Animal image 3
│       ├── 4.jpg                      # Animal image 4
│       ├── 5.jpg                      # Animal image 5
│       ├── 6.jpg                      # Animal image 6
│       ├── 7.jpg                      # Animal image 7
│       ├── 8.jpg                      # Animal image 8
│       ├── 9.jpg                      # Animal image 9
│       └── 10.jpg                     # Animal image 10
└── lib/
    ├── main.dart                      # App entry point
    ├── models/
    │   └── card_model.dart            # MemoryCard data model
    ├── screens/
    │   └── game_screen.dart           # Main game screen widget
    └── widgets/                       # Custom widget components
```

## Prerequisites

Before running this project, ensure you have the following installed:

- **Flutter SDK** (>=3.5.0)
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development on macOS)
- **Chrome browser** (for web development)

## Configuration & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd memory_match_game
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Verify Flutter Installation
```bash
flutter doctor
```
Ensure all required dependencies are properly installed.

### 4. Configure Platform Support (if needed)
```bash
# Add Android support
flutter create --platforms android .

# Add iOS support (macOS only)
flutter create --platforms ios .

# Add Web support
flutter create --platforms web .

# Add Windows support
flutter create --platforms windows .
```

## Running the Application

### Android Device/Emulator
```bash
# List available devices
flutter devices

# Run on connected Android device
flutter run -d android

# Run on specific device (replace with your device ID)
flutter run -d <device-id>
```

### iOS Simulator (macOS only)
```bash
# Run on iOS simulator
flutter run -d ios
```

### Web Browser
```bash
# Run on Chrome
flutter run -d chrome

# Run on any web browser
flutter run -d web-server
```

### Windows Desktop
```bash
# Run on Windows
flutter run -d windows
```

## Building for Release

### Android APK
```bash
flutter build apk
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Google Play Store)
```bash
flutter build appbundle
# Output: build/app/outputs/bundle/release/app-release.aab
```

### Windows Executable
```bash
flutter build windows
# Output: build/windows/runner/Release/
```

### Web Build
```bash
flutter build web
# Output: build/web/
```

## Game Instructions

1. **Start Game**: The app launches directly into the game screen
2. **Flip Cards**: Tap any face-down card to reveal the animal image
3. **Find Matches**: Tap a second card to find its matching pair
4. **Scoring**: Successfully matched pairs increment your score
5. **Mismatch**: Non-matching cards flip back after 1 second
6. **Win Condition**: Match all 10 pairs to complete the game
7. **Restart**: Use the "Restart" button to shuffle and start a new game

## Screenshots

### Initial Grid State
<!-- Screenshot placeholder: Show the initial 4x5 grid with all cards face-down -->
*[Insert screenshot of the initial game state with pastel-colored face-down cards showing "?" symbols]*

### Flipped/Matching State
<!-- Screenshot placeholder: Show cards being flipped and matched -->
*[Insert screenshot showing some cards flipped face-up with animal images visible and some matched pairs]*

### Game Progress
<!-- Screenshot placeholder: Show the score counter and partially completed game -->
*[Insert screenshot showing the score counter in the app bar and game in progress]*

### Restart Action
<!-- Screenshot placeholder: Show the restart button and its styling -->
*[Insert screenshot highlighting the premium-styled restart button at the bottom of the screen]*

## Technical Implementation

### Architecture
- **State Management**: StatefulWidget with local state management
- **Animation**: Custom AnimationControllers for card flip effects
- **Responsive Design**: LayoutBuilder for adaptive grid layouts
- **Model-View Separation**: Clean architecture with separate model classes

### Key Components
- **MemoryCard Model**: Data structure for individual cards
- **GameScreen**: Main game logic and UI rendering
- **Card Flip Animation**: 3D rotation effects using Transform and Matrix4
- **Responsive Grid**: Dynamic column count based on screen size

### Performance Optimizations
- Efficient animation controller management
- Proper widget disposal to prevent memory leaks
- Optimized image loading with error fallbacks
- Minimal rebuilds through targeted setState calls

## Development Tools

### Useful Commands
```bash
# Hot reload during development
# Press 'r' in terminal while app is running

# Hot restart
# Press 'R' in terminal while app is running

# Analyze code quality
flutter analyze

# Format code
flutter format .

# Run tests
flutter test

# Clean build cache
flutter clean
```

## Troubleshooting

### Common Issues

**1. Build Errors**
```bash
flutter clean
flutter pub get
flutter run
```

**2. Device Not Detected**
- Enable Developer Options and USB Debugging on Android
- Accept USB debugging prompt on device
- Try different USB cable or port

**3. iOS Build Issues (macOS)**
```bash
cd ios
pod install
cd ..
flutter run
```

**4. Web CORS Issues**
```bash
flutter run -d chrome --web-renderer html
```

## Project Requirements Met

**Flutter Framework**: Built with Flutter 3.5.0+
**Custom Widgets**: GameScreen with animated card components
**State Management**: Comprehensive game state handling
**Responsive Design**: Adaptive layouts for all screen sizes
**Asset Management**: Organized image assets with proper configuration
**Animation**: Smooth 3D card flip animations
**User Interface**: Polished, professional UI design
**Cross-Platform**: Supports Android, iOS, Web, and Windows

## Contributors

- **Course**: COMP5450 Mobile Programming
- **Institution**: Lakehead University

## License

This project is created for educational purposes as part of the COMP5450 Mobile Programming course at Lakehead University.