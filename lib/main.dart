import 'package:flutter/material.dart';
import 'package:todo_app/todo_page.dart';

void main() {
  runApp(MyApp());
}

/// The main widget of the Todo app.
/// It sets up the app's theme and home page.
/// The [MyApp] widget is the root of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData.dark(),

      home: Scaffold(
        appBar: AppBar(title: const Text("Todo App")),
        body: const TodoPageWidget(),
      ),
    );
  }
}
