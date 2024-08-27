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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBlHwgihrt9F36oRC9lgKxgBfW3UTdd4yI',
    appId: '1:1971688034:web:b3fe926edd56db79efb73b',
    messagingSenderId: '1971688034',
    projectId: 'today-note-project',
    authDomain: 'today-note-project.firebaseapp.com',
    storageBucket: 'today-note-project.appspot.com',
    measurementId: 'G-6XT4Q1G7EZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCUjRWDqeScJlQb1lgmj8OXM-PJCE1AJQw',
    appId: '1:1971688034:android:186d13b2552877d6efb73b',
    messagingSenderId: '1971688034',
    projectId: 'today-note-project',
    storageBucket: 'today-note-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7utCm2moJuzqjOKV0RGwB5X35vH5bmW8',
    appId: '1:1971688034:ios:39617ae8134d3e96efb73b',
    messagingSenderId: '1971688034',
    projectId: 'today-note-project',
    storageBucket: 'today-note-project.appspot.com',
    iosBundleId: 'com.kthdd.todayNote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7utCm2moJuzqjOKV0RGwB5X35vH5bmW8',
    appId: '1:1971688034:ios:0682e60469820d3eefb73b',
    messagingSenderId: '1971688034',
    projectId: 'today-note-project',
    storageBucket: 'today-note-project.appspot.com',
    iosBundleId: 'com.example.praiseDiaryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBlHwgihrt9F36oRC9lgKxgBfW3UTdd4yI',
    appId: '1:1971688034:web:30aa11c61c78362cefb73b',
    messagingSenderId: '1971688034',
    projectId: 'today-note-project',
    authDomain: 'today-note-project.firebaseapp.com',
    storageBucket: 'today-note-project.appspot.com',
    measurementId: 'G-7W22S79BGL',
  );
}
