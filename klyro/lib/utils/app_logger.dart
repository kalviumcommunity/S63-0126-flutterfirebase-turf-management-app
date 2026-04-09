import 'package:flutter/foundation.dart';

// Utility class wrapper for logging safely to terminal 
class AppLogger {
  // Private constructor explicitly prevents anyone from instantiating this class via new AppLogger()
  const AppLogger._();

  // Static method that receives a string and prints it globally
  static void debug(String message) {
    // kDebugMode evaluates to true ONLY when running locally in dev mode.
    // This stops our app from printing debugging secrets in the live production release.
    if (kDebugMode) {
      debugPrint(message);
    }
  }
}
