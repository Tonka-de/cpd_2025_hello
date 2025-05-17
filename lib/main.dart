import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/router/router.dart';
import 'package:flutter_aufgaben/services/postgre.service.dart';

void main() async {
  await PostgreService.prepareDatabase();

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
      routes: buildAppRoutes(),
      initialRoute: '/todo',
    );
  }
}
