import 'package:flutter/material.dart';
import 'package:enrico_kevin_ariantho_software_testing_midterm/Model/user.dart';
import 'package:enrico_kevin_ariantho_software_testing_midterm/Data/Network/AuthService.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;
  User? _user;
  bool _isLoading = false;
  String? _error;

  AuthViewModel({AuthService? authService})
      : _authService = authService ?? AuthService();

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;

  String? validateUsername(String username) {
    if (username.isEmpty) return "Username cannot be empty.";
    if (username.length < 3 || username.length > 20) return "Username must be between 3 and 20 characters.";
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) return "Username contains invalid characters.";
    return null;
  }

  String? validatePassword(String password) {
    if (password.length < 6) return "Password must be at least 6 characters long.";
    return null;
  }

  Future<String?> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authService.login(username, password);
      _user = User.fromJson(result);
      _isLoading = false;
      notifyListeners();
      return null; // login success
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return _error; // login failed
    }
  }

  Future<void> logout() async {
    // await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
