import 'package:flutter_test/flutter_test.dart';
import 'package:enrico_kevin_ariantho_software_testing_midterm/ViewModel/AuthViewModel.dart';
import 'package:enrico_kevin_ariantho_software_testing_midterm/Data/Network/AuthService.dart';

// Fake AuthService implementation
class FakeAuthService implements AuthService {
  bool shouldFailLogin = false;
  bool logoutCalled = false;

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    if (shouldFailLogin) {
      throw Exception('Invalid username or password.');
    }

    // Simulasi response login sukses dengan data lengkap User
    return {
      'id': 1,
      'username': "emilys",
      'email': "emily.johnson@x.dummyjson.com",
      'firstName': "Emily",
      'lastName': "Johnson",
      'gender': "female",
      'image': "https://dummyjson.com/icon/emilys/128",
      'token': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      'refreshToken': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    };
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
    // Simulasi delay logout
    await Future.delayed(Duration(milliseconds: 100));
  }
}

void main() {
  late AuthViewModel authViewModel;
  late FakeAuthService fakeAuthService;

  setUp(() {
    fakeAuthService = FakeAuthService();
    authViewModel = AuthViewModel(authService: fakeAuthService);
  });

  test('TC_AUTH_VM_001: Validate Empty Username', () {
    final result = authViewModel.validateUsername('');
    expect(result, "Username cannot be empty.");
  });

  test('TC_AUTH_VM_002: Validate Short Password', () {
    final result = authViewModel.validatePassword('123');
    expect(result, "Password must be at least 6 characters long.");
  });

  test('TC_AUTH_VM_003: Successful Login', () async {
    fakeAuthService.shouldFailLogin = false;

    final result = await authViewModel.login('emilys', 'emilyspass');
    expect(result, null);
    expect(authViewModel.isLoggedIn, true);
  });

  test('TC_AUTH_VM_004: Login with Invalid Credentials', () async {
    fakeAuthService.shouldFailLogin = true;

    final result = await authViewModel.login('invaliduser', 'wrongpassword');
    expect(result, 'Invalid username or password.');
    expect(authViewModel.isLoggedIn, false);
  });

  test('TC_AUTH_VM_005: Logout Functionality', () async {
    await authViewModel.logout();
    expect(authViewModel.isLoggedIn, false);
    expect(fakeAuthService.logoutCalled, true);
  });

  test('TC_AUTH_VM_006: Username Length Boundary Values', () {
    expect(authViewModel.validateUsername('ab'), isNotNull); // Too short
    expect(authViewModel.validateUsername('a' * 21), isNotNull); // Too long
    expect(authViewModel.validateUsername('abc123'), null); // Valid
  });

  test('TC_AUTH_VM_007: Password Length Boundary Values', () {
    expect(authViewModel.validatePassword('12345'), isNotNull);
    expect(authViewModel.validatePassword('123456'), null);
  });

  test('TC_AUTH_VM_008: Username with Special Characters', () {
    final result = authViewModel.validateUsername('test@user!');
    expect(result, "Username contains invalid characters.");
  });

  test('TC_AUTH_VM_009: SQL Injection Attempt', () async {
    fakeAuthService.shouldFailLogin = true;

    final result = await authViewModel.login("' OR '1'='1", 'any');
    expect(result, 'Invalid username or password.');
  });

  test('TC_AUTH_VM_010: Login with Empty Fields', () {
    final usernameError = authViewModel.validateUsername('');
    final passwordError = authViewModel.validatePassword('');
    expect(usernameError, isNotNull);
    expect(passwordError, isNotNull);
  });
}
