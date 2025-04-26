import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/widgets/appbar.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_page.dart';

/// A screen that displays a Todo list.
class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Todo"),
      body: const TodoPageWidget(),
    );
  }
}
