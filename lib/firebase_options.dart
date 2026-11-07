import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for linux - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment(
      'apiKey',
      defaultValue: 'your_api_key',
    ),
    appId: String.fromEnvironment(
      'androidAppId',
      defaultValue: 'your_android_app_id',
    ),
    messagingSenderId: String.fromEnvironment(
      'messagingSenderId',
      defaultValue: 'your_messaging_sender_id',
    ),
    projectId: String.fromEnvironment(
        'projectId',
        defaultValue: 'your_project_id'
    ),
    storageBucket: String.fromEnvironment(
      'storageBucket',
      defaultValue: 'your_storage_bucket',
    ),
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment(
      'apiKey',
      defaultValue: 'your_api_key',
    ),
    appId: String.fromEnvironment(
      'iosAppId',
      defaultValue: 'your_ios_app_id',
    ),
    messagingSenderId: String.fromEnvironment(
      'messagingSenderId',
      defaultValue: 'your_messaging_sender_id',
    ),
    projectId: String.fromEnvironment(
      'projectId',
        defaultValue: 'your_project_id'
    ),
    storageBucket: String.fromEnvironment(
      'storageBucket',
      defaultValue: 'your_storage_bucket',
    ),
    iosBundleId: String.fromEnvironment(
      'iosBundleId',
      defaultValue: 'your_ios_bundle_id',
    ),
  );
}
