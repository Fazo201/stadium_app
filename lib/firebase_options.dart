// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCIL-DoUyfDJtyIVhIP6nbAE231pOxqY9g',
    appId: '1:1023117327100:web:3643e0c55078fc62a3b579',
    messagingSenderId: '1023117327100',
    projectId: 'stadium-app-7dd77',
    authDomain: 'stadium-app-7dd77.firebaseapp.com',
    storageBucket: 'stadium-app-7dd77.appspot.com',
    measurementId: 'G-WS3B1LKMFH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmTZT0YuShQB69azUpNgWDaIAXvU_CkAQ',
    appId: '1:1023117327100:android:060ddde17df03b05a3b579',
    messagingSenderId: '1023117327100',
    projectId: 'stadium-app-7dd77',
    storageBucket: 'stadium-app-7dd77.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbWbqyXiE3uItmsHh9EzEyWYsOq6WDyeQ',
    appId: '1:1023117327100:ios:ca559b68f5292657a3b579',
    messagingSenderId: '1023117327100',
    projectId: 'stadium-app-7dd77',
    storageBucket: 'stadium-app-7dd77.appspot.com',
    iosBundleId: 'com.fazo.stadiumProject',
  );
}
