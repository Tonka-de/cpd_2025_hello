import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/widgets/appbar.dart';
import 'package:flutter_aufgaben/widgets/login_dialog.dart';

/// A screen that displays a login dialog.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Login"),
      body: Center(child: LoginDialogWidget()),
    );
  }
}
