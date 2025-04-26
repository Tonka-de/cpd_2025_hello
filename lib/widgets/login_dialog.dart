import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/store/secure_storage.dart';

/// A widget that displays a login dialog with username and password fields.
///
/// This widget uses the [SecureStorage] class to read hardcoded credentials
/// and validate user input. If the login is successful, it navigates to the Todo screen.
/// If the login fails, it shows an error message.
class LoginDialogWidget extends StatefulWidget {
  const LoginDialogWidget({super.key});

  @override
  State<LoginDialogWidget> createState() => _LoginDialogWidgetState();
}

/// The state for the [LoginDialogWidget].
class _LoginDialogWidgetState extends State<LoginDialogWidget> {
  /// The formkey to validate the form.
  final _formKey = GlobalKey<FormState>();

  /// The controller for the username text field.
  final TextEditingController _usernameController = TextEditingController();

  /// The controller for the password text field.
  final TextEditingController _passwordController = TextEditingController();

  /// Function to handle the login process.
  /// It reads the hardcoded credentials from secure storage and the controller values.
  /// If the credentials match, it navigates to the Todo screen.
  /// If the credentials do not match, it shows an error message.
  Future<void> handleLogin() async {
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    var credentials = await readCredentials();

    // Validate against hardcoded credentials
    if (credentials.username == enteredUsername &&
        credentials.password == enteredPassword) {
      clearTextFields();
      // Navigate to the next screen
      navigateToTodoScreen();
    } else {
      // Show an error message
      handleLoginFail();
    }
  }

  /// Function to clear the text fields.
  void clearTextFields() {
    _usernameController.clear();
    _passwordController.clear();
  }

  /// Function to show an error message when login fails.
  void handleLoginFail() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  /// Function to navigate to the Todo screen.
  void navigateToTodoScreen() {
    Navigator.pushNamed(context, '/todo');
  }

  /// Function to validate the username input.
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  /// Function to validate the password input.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: validateUsername,
              onEditingComplete: handleLogin,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onEditingComplete: handleLogin,
              validator: validatePassword,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: handleLogin, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
