import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthService extends GetxController {
  AuthService() {
    // Initialize Amplify Auth in the constructor
    initialize();
  }

  // Initialize Amplify Auth
  Future<void> initialize() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
    } catch (e) {
      print('Error initializing Amplify Auth: $e');
    }
  }
  //Sign Up
  Future<void> signUp(String username, String password) async {
    try {
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
      );
      if (result.isSignUpComplete) {
        // User registration is complete
      } else {
        // User registration is not yet complete
      }
    } catch (e) {
      print('Error signing up: $e');
      throw e; // You can rethrow the error to handle it in the UI
    }
  }

  // Sign in with username and password
  Future<void> signIn(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      if (result.isSignedIn) {
        // User is signed in
      } else {
        // User could not be signed in
      }
    } catch (e) {
      print('Error signing in: $e');
    }
  }

  // Sign out the currently authenticated user
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      // User is signed out
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}