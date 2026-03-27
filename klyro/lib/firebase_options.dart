import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGGdWJgHvj6VHvsLrpQv4oS3bGzKToKr0',
    appId: '1:1059952502795:android:745ab014efb057d5b53f0e',
    messagingSenderId: '1059952502795',
    projectId: 'orbit-1699f',
    storageBucket: 'orbit-1699f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCobdl_sDbjmHZ1ZI3T8wR0aufBhIYNEhY',
    appId: '1:1059952502795:web:006f6238e2a6fe4db53f0e',
    messagingSenderId: '1059952502795',
    projectId: 'orbit-1699f',
    authDomain: 'orbit-1699f.firebaseapp.com',
    storageBucket: 'orbit-1699f.firebasestorage.app',
  );

}