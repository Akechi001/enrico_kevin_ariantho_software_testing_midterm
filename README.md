# enrico_kevin_ariantho_software_testing_midterm

## Overview
A Flutter application implementing user authentication using MVVM architecture. Users can log in using DummyJSON API.

## Architecture
- **Model:** Defines user data.
- **ViewModel:** Handles input validation, login/logout logic.
- **View:** Flutter UI (minimal, for login/logout).
- **Tests:** Unit tests for ViewModel covering edge cases and input validation.

## Test Cases
- TC_AUTH_VM_001 to TC_AUTH_VM_010 (see `test/auth_view_model_test.dart` for details).

## How to Run
1. Clone repo
2. Run `flutter pub get`
3. Run tests using:
   
```bash
flutter test test/auth_view_model_test.dart
```
