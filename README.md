# enrico_kevin_ariantho_software_testing_midterm

## Overview
A Flutter application implementing user authentication using MVVM architecture. Users can log in using DummyJSON API.

## Architecture
- **Model:** Defines user data.
- **ViewModel:** Handles input validation, login/logout logic.
- **View:** UI Application (Homepage, Loginscreen and widget).
- **Tests:** Unit tests for ViewModel covering edge cases and input validation.

## Test Cases
- TC_AUTH_VM_001 to TC_AUTH_VM_010 (see `test/auth_view_model_test.dart` for details).

## Test Include
   1. Validate Empty Username
   2. Validate Short Password
   3. Successful Login
   4. Login with Invalid Credentials
   5. Logout Functionality
   6. Username Length Boundary Values
   7. Password Length Boundary Values
   8. Login with Special Characters in Username
   9. Login with SQL Injection Attempt
   10. Login with Empty Fields

## How to Run
1. Clone repo
2. Run `flutter pub get`
3. Run tests using:
   
```bash
flutter test test/auth_view_model_test.dart
```

## Overview Application
<img src="https://github.com/user-attachments/assets/358a3ab7-0167-4681-84a5-e36dc981743e" width="300"/>
<img src="https://github.com/user-attachments/assets/7b556f54-0a10-4d9a-b5db-65e3f1a9bad0" width="300"/>


## Complete Test Case
![Screenshot 2025-05-22 113620](https://github.com/user-attachments/assets/79c30fc1-d20f-4991-9cdf-b904c5981952)
