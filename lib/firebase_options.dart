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
    apiKey: 'AIzaSyBbRdVKwn5UWZt6jxaye2CelyGQMaV2lbg',
    appId: '1:503524466422:web:2a636e9a04de8be17596d7',
    messagingSenderId: '503524466422',
    projectId: 'games-room-b1b2d',
    authDomain: 'games-room-b1b2d.firebaseapp.com',
    storageBucket: 'games-room-b1b2d.appspot.com',
    measurementId: 'G-J4E50X626X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5BQ2LHY16nd2zitF67rZcbIZN46a5jHg',
    appId: '1:503524466422:android:a2cbcaef8263d1277596d7',
    messagingSenderId: '503524466422',
    projectId: 'games-room-b1b2d',
    storageBucket: 'games-room-b1b2d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcc1rG1XlCHIOLDBLkwZRpHr7PSV6Ii-w',
    appId: '1:503524466422:ios:ea4fb22891e20a997596d7',
    messagingSenderId: '503524466422',
    projectId: 'games-room-b1b2d',
    storageBucket: 'games-room-b1b2d.appspot.com',
    iosClientId: '503524466422-bfnq3s331sl71nc6273iv2tfga7mcrsh.apps.googleusercontent.com',
    iosBundleId: 'com.example.gamesroom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcc1rG1XlCHIOLDBLkwZRpHr7PSV6Ii-w',
    appId: '1:503524466422:ios:bdd6d9322372388e7596d7',
    messagingSenderId: '503524466422',
    projectId: 'games-room-b1b2d',
    storageBucket: 'games-room-b1b2d.appspot.com',
    iosClientId: '503524466422-8qd6b5l9b62r4ffb9com2brdlbq4l922.apps.googleusercontent.com',
    iosBundleId: 'com.example.gamesroom.RunnerTests',
  );
}