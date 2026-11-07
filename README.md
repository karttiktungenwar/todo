# Cloud-Connected Note & Todo App (Flutter)

A cross-platform (Android & iOS) Note & Todo application built with **Flutter** and **Firebase Cloud Firestore**, following **Clean Architecture** and strict **SOLID principles**.

* **Repository:** [https://github.com/karttiktungenwar/todo/](https://github.com/karttiktungenwar/todo/)
* **Package Name / Application ID:** `com.todo`
* **Bundle Identifier:** `com.todo`

---

## Architecture & SOLID Overview

The project adheres to Uncle Bob's Clean Architecture, dividing the codebase into three decoupled layers:

```text
lib/
├── app/di/
│   └── injection_container.dart       # Service locator (GetIt) setup
├── core/
│   ├── error/                         # Failures & Exceptions
│   ├── usecase/                       # Base UseCase contracts
│   └── extensions/                    # BuildContext helpers
├── features/
│   └── todo/
│       ├── domain/                    # Enterprise Business Rules (Entities, UseCases, Repository interfaces)
│       ├── data/                      # Data Sources, DTOs/Models, Repository implementations
│       └── presentation/              # BLoC, Pages, and UI Widgets
├── firebase_options.dart              # Firebase configuration loader
└── main.dart                          # Application entry point
SOLID Mapping
Single Responsibility Principle (SRP): Each class owns one responsibility (e.g., UseCases encapsulate a single action; DataSources interact only with Firestore).

Open/Closed Principle (OCP): Domain logic relies on abstract repositories. You can swap Firestore for SQLite/Hive without altering business rules.

Liskov Substitution Principle (LSP): TodoItemModel implements TodoItem directly and can substitute it anywhere without side effects.

Interface Segregation Principle (ISP): Repositories and UseCases define discrete, minimal interfaces so consumers depend only on methods they actually call.

Dependency Inversion Principle (DIP): High-level domain entities and use cases do not depend on low-level data layer packages (e.g., cloud_firestore). Dependencies are inverted and injected using get_it.

Prerequisites
Flutter SDK (v3.19+ recommended)

Firebase CLI & FlutterFire CLI

Node.js (for Firebase Tools)

Android Studio / Xcode

Firebase Setup & Configuration
1. Create Firebase Project
Go to the Firebase Console.

Create a project named cloud-todo-6233f (or your preferred project name).

Under Build, select Firestore Database -> Create Database in (default) mode.

Set up security rules allowing authenticated access:

JavaScript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId}/todos/{todoId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
Enable Anonymous Authentication (or Email/Password) under Build > Authentication > Sign-in method.

2. Configure Platforms (Package Name: com.todo)
Run the FlutterFire CLI command from the project root:

Bash
flutterfire configure --project=cloud-todo-6233f \
  --platforms=android,ios \
  --android-package-name=com.todo \
  --ios-bundle-id=com.todo
This will automatically generate lib/firebase_options.dart and download:

android/app/google-services.json

ios/Runner/GoogleService-Info.plist

Secrets Management (secrets.json)
To keep keys out of version control, store your Firebase configuration keys in secrets.json at the root directory:

JSON
{
  "apiKey": "YOUR_FIREBASE_API_KEY",
  "androidAppId": "YOUR_ANDROID_APP_ID",
  "iosAppId": "YOUR_IOS_APP_ID",
  "messagingSenderId": "YOUR_MESSAGING_SENDER_ID",
  "projectId": "YOUR_PROJECT_ID",
  "storageBucket": "YOUR_STORAGE_BUCKET_URL",
  "iosBundleId": "com.todo"
}
Note: Add secrets.json, google-services.json, and GoogleService-Info.plist to your .gitignore before committing:

Code snippet
secrets.json
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
Quick Start & Implementation Workflow
Clone the repository:

Bash
git clone [https://github.com/karttiktungenwar/todo.git](https://github.com/karttiktungenwar/todo.git)
cd todo
Install dependencies:

Bash
flutter pub get
Verify Bundle / Package IDs:

Android (android/app/build.gradle):

Groovy
defaultConfig {
    applicationId "com.todo"
    minSdkVersion 21
    targetSdkVersion 34
}
iOS (ios/Runner.xcodeproj/project.pbxproj):
Ensure PRODUCT_BUNDLE_IDENTIFIER is com.todo.

Initialize Firebase & DI in main.dart:

Dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencyInjection();

  // Sign in anonymously to satisfy security rules
  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    await auth.signInAnonymously();
  }

  runApp(const MyApp());
}
Run the App:

Bash
flutter run
Verification & Testing
1. Automated Testing
Run the suite of unit and BLoC tests:

Bash
flutter test
2. Firestore Offline Sync Verification
Launch the app on an Android Emulator or iOS Simulator.

Add a new todo item while connected to the internet.

Enable Airplane Mode on the device.

Add another todo item. The item appears instantly in the list due to Firestore's local cache.

Disable Airplane Mode.

Open the Firebase Console -> Firestore Database, and verify that the pending item has synced to the users/{userId}/todos subcollection.

License
This project is open-source and available under the MIT License.