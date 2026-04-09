import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Standard configurations auto-generated strictly by the FlutterFire CLI pipeline.
// These variables act as physical API keys explicitly pointing the application toward the backend.
class DefaultFirebaseOptions {
  
  // A dynamic getter mapping exactly which platform the physical device is running on at runtime.
  static FirebaseOptions get currentPlatform {
    // Evaluates instantly if the program is hosted over a Web browser engine (skips physical TargetPlatform checks)
    if (kIsWeb) {
      return web;
    }
    
    // Explicit switch evaluating binary OS flags dynamically natively 
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Returns the structural JSON node array designed specifically connecting strictly to Android Ecosystem APIs
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        // Deliberately drops an execution block because the CLI was not prompted to generate setups for these environments
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
      default:
        // Failsafe execution dropout completely guarding against unknown platform execution states safely
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  // Const dictionary definitively declaring exact backend authorization routes specifically mapped onto the Android App architecture
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGGdWJgHvj6VHvsLrpQv4oS3bGzKToKr0', // Specific routing token
    appId: '1:1059952502795:android:745ab014efb057d5b53f0e', // Target identifier explicitly matched within Google Cloud
    messagingSenderId: '1059952502795', // Mapping for push notifications payloads natively 
    projectId: 'orbit-1699f',
    storageBucket: 'orbit-1699f.firebasestorage.app', // Routing connection exactly specifying asset storage buckets mapping
  );

  // Blank structural iOS bindings locally 
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );

  // Blank structural MacOS bindings locally 
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );

  // Specialized Web variables providing explicitly Web-only data nodes seamlessly mapping to browser domains natively 
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCobdl_sDbjmHZ1ZI3T8wR0aufBhIYNEhY',
    appId: '1:1059952502795:web:006f6238e2a6fe4db53f0e',
    messagingSenderId: '1059952502795',
    projectId: 'orbit-1699f',
    authDomain: 'orbit-1699f.firebaseapp.com', // Defines exactly which external domain holds session routing logic 
    storageBucket: 'orbit-1699f.firebasestorage.app',
  );

}