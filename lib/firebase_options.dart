
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
    apiKey: 'AIzaSyAcLo4Y1-zOFkEl1hohStoiHuk0pIPXt98',
    appId: '1:203604351647:web:f71ea822909ba9908d20aa',
    messagingSenderId: '203604351647',
    projectId: 'fir-login-6bddb',
    authDomain: 'fir-login-6bddb.firebaseapp.com',
    storageBucket: 'fir-login-6bddb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDO9FWmOYDesLOIp5xOGVaVrHWVF1rQMwg',
    appId: '1:203604351647:android:e06a09afe7cbcffc8d20aa',
    messagingSenderId: '203604351647',
    projectId: 'fir-login-6bddb',
    storageBucket: 'fir-login-6bddb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwxj-5_xggN_cU5Antj4z6DW89aVl30nA',
    appId: '1:203604351647:ios:62288e41d21b04f38d20aa',
    messagingSenderId: '203604351647',
    projectId: 'fir-login-6bddb',
    storageBucket: 'fir-login-6bddb.appspot.com',
    iosClientId: '203604351647-ope9d8c0vi6305rq3q8vu7t4t1cndq5o.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginFirebaseFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAwxj-5_xggN_cU5Antj4z6DW89aVl30nA',
    appId: '1:203604351647:ios:62288e41d21b04f38d20aa',
    messagingSenderId: '203604351647',
    projectId: 'fir-login-6bddb',
    storageBucket: 'fir-login-6bddb.appspot.com',
    iosClientId: '203604351647-ope9d8c0vi6305rq3q8vu7t4t1cndq5o.apps.googleusercontent.com',
    iosBundleId: 'com.example.loginFirebaseFlutter',
  );
}
