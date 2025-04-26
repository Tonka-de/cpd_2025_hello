import 'package:flutter/material.dart';

/// A custom AppBar widget that provides a consistent app bar design across the application.
///
/// This widget implements the [PreferredSizeWidget] interface, allowing it to be used as an app bar
/// in a [Scaffold].
///
/// Properties:
/// - [title]: The text to display as the title of the app bar.
/// This property is required.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display in the app bar.
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
      elevation: 4.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
