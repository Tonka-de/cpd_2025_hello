import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/views/login_screen.dart';
import 'package:flutter_aufgaben/views/todo_screen.dart';

/// A function to define the routes for the application.
Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (context) => LoginScreen(),
    '/todo': (context) => TodoScreen(),
  };
}
