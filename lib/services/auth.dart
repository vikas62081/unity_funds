import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:unity_funds/modals/user.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

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

  Future<void> createAccount(User user, String password) async {
    try {
      // Create user with email and password
      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set(user.toFirestore());

      print('Account created successfully');
    } catch (e) {
      print('Account creation failed: $e');
      // Handle account creation failure
    }
  }

  Future<void> logOut() {
    return firebase_auth.FirebaseAuth.instance.signOut();
  }

  firebase_auth.User? getActiveUser() {
    return firebase_auth.FirebaseAuth.instance.currentUser;
  }
}
