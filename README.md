# 📝 To-Do App

A modern, feature-rich To-Do application built with Flutter, featuring clean architecture, local data persistence, and comprehensive testing.

## ✨ Features

- ✅ **Task Management**: Create, read, update, and delete tasks
- 🎯 **Task Filtering**: Filter tasks by status (All, Completed, Pending)
- 💾 **Local Storage**: Persistent data storage using Hive database
- 🎨 **Modern UI**: Clean and intuitive dark-themed interface
- 📱 **Responsive Design**: Adaptive layouts using ScreenUtil
- 🧪 **Comprehensive Testing**: Unit, widget, and integration tests
- 🏗️ **Clean Architecture**: Separation of concerns with layered architecture
- 🔄 **State Management**: Provider pattern for efficient state handling

## 🏛️ Architecture

The app follows **Clean Architecture** principles with clear separation of layers:

```
lib/
├── core/
│   └── utils/
│       ├── route_pages.dart       # Navigation configuration
│       └── service_locator.dart   # Dependency injection
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── models/           # Data models (ToDoModel)
│   │   │   └── repo/             # Repository implementation
│   │   └── presentation/
│   │       ├── view_models/      # Providers (state management)
│   │       └── views/            # UI screens and widgets
│   └── splash/
│       └── presentation/
│           └── views/            # Splash screen
└── main.dart                     # App entry point
```

## 📦 Tech Stack

### Core Dependencies
- **flutter_screenutil** (^5.9.3) - Responsive UI design
- **hive** (^2.2.3) - Lightweight and fast NoSQL database
- **hive_flutter** (^1.1.0) - Hive integration for Flutter
- **provider** (^6.1.5+1) - State management
- **go_router** (^17.0.1) - Declarative routing
- **get_it** (^9.2.0) - Service locator for dependency injection

### Development Dependencies
- **mockito** (^5.4.4) - Mocking framework for testing
- **build_runner** (^2.4.13) - Code generation
- **hive_generator** (^2.0.1) - Generate Hive type adapters
- **flutter_test** - Widget and unit testing
- **integration_test** - End-to-end testing

## � Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK (^3.9.2)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd to_do_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (Hive adapters)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

The app includes comprehensive test coverage:

### Run All Tests
```bash
flutter test
```

### Run Specific Test Suites

**Unit Tests**
```bash
flutter test test/models/to_do_model_test.dart
flutter test test/repo/to_do_repository_test.dart
flutter test test/provider/to_do_provider_test.dart
```

**Widget Tests**
```bash
flutter test test/widgets/home_view_body_widget_test.dart
flutter test test/widgets/task_item_widget_test.dart
```

**Integration Tests**
```bash
flutter test integration_test/integration_test.dart
```

### Test Coverage
```bash
flutter test --coverage
```

## 📱 Screens

1. **Splash Screen**: Animated welcome screen with smooth transitions
2. **Home View**: Main task list with filtering options
3. **Add Task View**: Create new tasks
4. **Update Task View**: Edit existing tasks

## 🎯 Key Features Explained

### Task Filtering
- **All Tasks**: View all tasks regardless of status
- **Completed**: Show only completed tasks
- **Pending**: Show only incomplete tasks

### Data Persistence
- Uses Hive for fast, local NoSQL storage
- Automatic data synchronization
- Type-safe models with code generation

### State Management
- Provider pattern for reactive UI updates
- Centralized state in `ToDoProvider`
- Efficient rebuilds with `ChangeNotifier`

## 🔧 Configuration

### Screen Design Size
The app uses a base design size of **375x812** (iPhone X). Adjust in `main.dart`:
```dart
ScreenUtilInit(
  designSize: const Size(375, 812),
  // ...
)
```

### Theme
Dark theme with custom background color `#121212`. Modify in `main.dart`:
```dart
theme: ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF121212),
),
```

## 📂 Project Structure

```
to_do_app/
├── android/              # Android native code
├── ios/                  # iOS native code
├── lib/                  # Flutter application code
├── test/                 # Test files
│   ├── integration/      # Integration tests
│   ├── models/           # Model tests
│   ├── provider/         # Provider tests
│   ├── repo/             # Repository tests
│   └── widgets/          # Widget tests
├── assets/
│   └── images/           # Image assets
├── pubspec.yaml          # Dependencies
└── README.md             # This file
```

## 🛠️ Development

### Adding New Features
1. Create feature folder in `lib/features/`
2. Follow clean architecture layers (data/domain/presentation)
3. Register dependencies in `service_locator.dart`
4. Add routes in `route_pages.dart`
5. Write tests for new functionality

### Code Generation
When modifying Hive models, regenerate adapters:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Built with ❤️ using Flutter

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Hive for fast local storage
- Provider for simple state management
- The Flutter community for continuous support

---

**Note**: This is a learning project demonstrating Flutter best practices, clean architecture, and comprehensive testing strategies.
