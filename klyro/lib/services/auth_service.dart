import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Isolated Service Class managing Authentication connections to Firebase backend
class AuthService {
  // A private variable pointer holding the Firebase connection reference
  final FirebaseAuth _auth;

  // Constructor defaults to standard FirebaseAuth.instance, but allows passing standard mocked variables during testing.
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  // Fetch the active account session payload out of Firebase natively
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Wraps Firebase account creation resolving async network callbacks
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      // Calls Firebase server creating account natively
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      // If it fails (e.g. email exists), parse the error cleanly before tossing it to the UI
      throw Exception(_mapAuthError(error));
    }
  }

  // Identical to SignUp logic pathway but directs towards logging inside an existing account securely.
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapAuthError(error));
    }
  }

  // Force clears local authentication keychain terminating session logic immediately
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Placeholder preventing errors if execution attempts to link Google bindings dynamically without the plugin implementation loaded 
  Future<UserCredential> signInWithGoogle() async {
    throw UnimplementedError("Google Sign-In not supported on Web");
  }

  // Standard process mapping password overrides
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    // Evaluates presence ensuring null blocks break before throwing network connection exceptions.
    if (user == null || user.email == null) {
      throw Exception('No authenticated user found.');
    }
    try {
      // Create a fresh secure credential package (Firebase forces a secure refresh to touch passwords)
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      // Validates against server and immediately executes overwrite if returned clean
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapAuthError(error));
    }
  }

  // Giant String interpretation dictionary matching cryptic Backend mappings down to simple human paragraphs
  String _mapAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      default:
        // Absolute fallback array if mapping string is entirely missing
        return error.message ?? 'Authentication error. Please try again.';
    }
  }
}
