import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String phoneNumber, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: phoneNumber,
        password: password,
      );
      print('Login successful');
    } catch (e) {
      print('Login failed: $e');
      // Handle login failure
    }
  }

  Future<void> createAccount(String email, String password) async {
    try {
      // Create user with email and password
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Account created successfully');
    } catch (e) {
      print('Account creation failed: $e');
      // Handle account creation failure
    }
  }
}
