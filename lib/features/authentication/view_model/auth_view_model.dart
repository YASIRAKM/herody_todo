import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/constants/strings.dart';
import 'package:todo_app/core/service/firebase_auth_errors.dart';
import 'package:todo_app/core/service/shared_preferences_helper.dart';

import 'package:todo_app/data/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isRegister = false;

  User? _user;
  User? get user => _user;
  bool get isRegister => _isRegister;

  bool get isLoggedIn => _user != null;

  AuthViewModel() {
    _user = _auth.currentUser;
  }
  // swith signup login
  switchLoginSignup() {
    _isRegister = !_isRegister;
    notifyListeners();
  }

//Login
  Future<(bool, String)> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = _auth.currentUser;

      String? token = await _user!.getIdToken();
      if (token != null) {
        SharedPrefHelper.saveValue(AppStringContants.tokenKey, token);
        SharedPrefHelper.saveValue(AppStringContants.userIdKey, _user!.uid);
      }

      notifyListeners();
      return (true, "Success");
    } on FirebaseAuthException catch (e) {
      notifyListeners();

      return (false, fireBaseAuthError(e.code));
    }
  }

// Signup
  Future<(bool, String)> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = _auth.currentUser;

      (bool, String) res = await AuthRepository.saveUserDetails(_user!);

      return (res.$1, res.$2);

      // notifyListeners();
    } on FirebaseAuthException catch (e) {
      notifyListeners();
      return (false, fireBaseAuthError(e.code));
    }
  }

//logout
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      _user = null;
      SharedPrefHelper.clear();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

// reset password
  Future<bool> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }
}
