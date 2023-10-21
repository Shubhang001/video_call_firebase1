// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDblCgWiVz5YZvus425m-tuosyUEoLRORQ',
    appId: '1:1027870333224:web:32519ea931ed96ac44981d',
    messagingSenderId: '1027870333224',
    projectId: 'zegocloud-videocall-7acba',
    authDomain: 'zegocloud-videocall-7acba.firebaseapp.com',
    storageBucket: 'zegocloud-videocall-7acba.appspot.com',
    measurementId: 'G-TRD1MH8K19',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWwc0xKPWmUrte5t2U4uDsSv8H8-2xGNE',
    appId: '1:1027870333224:android:3ea0fcad54a35e2744981d',
    messagingSenderId: '1027870333224',
    projectId: 'zegocloud-videocall-7acba',
    storageBucket: 'zegocloud-videocall-7acba.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6Ii_CQrbS7KPvgLrq5Gt-OqbWlD18gPk',
    appId: '1:1027870333224:ios:869a616c6ceb1d3444981d',
    messagingSenderId: '1027870333224',
    projectId: 'zegocloud-videocall-7acba',
    storageBucket: 'zegocloud-videocall-7acba.appspot.com',
    iosBundleId: 'com.example.videoCallFirebase1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6Ii_CQrbS7KPvgLrq5Gt-OqbWlD18gPk',
    appId: '1:1027870333224:ios:927bdd2cfbd200b244981d',
    messagingSenderId: '1027870333224',
    projectId: 'zegocloud-videocall-7acba',
    storageBucket: 'zegocloud-videocall-7acba.appspot.com',
    iosBundleId: 'com.example.videoCallFirebase1.RunnerTests',
  );
}
