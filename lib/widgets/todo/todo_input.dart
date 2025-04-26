import 'package:flutter/material.dart';

/// A widget that provides an input field for adding new todo items.
///
/// Properties:
/// - [onAdd]: A callback function that is triggered when a new todo item is submitted.
///   The function receives the entered text as a parameter.
/// This attribute is required.
class TodoInputWidget extends StatefulWidget {
  /// Callback function to handle the addition of a new todo item.
  /// It takes the text of the new item as a parameter.
  /// This attribute is required and cannot be null.
  final void Function(String text) onAdd;

  const TodoInputWidget({super.key, required this.onAdd});

  @override
  State<TodoInputWidget> createState() => _TodoInputWidgetState();
}

/// The state class for [TodoInputWidget].
///
/// This class manages the state of the input field and handles the logic for submitting new tasks.
/// It ensures that the input field is cleared after a task is submitted.
class _TodoInputWidgetState extends State<TodoInputWidget> {
  final TextEditingController _controller = TextEditingController();

  /// Submits the entered text as a new todo item.
  ///
  /// If the input field is empty, the submission is ignored. Otherwise, the entered text
  /// is passed to the [onAdd] callback, and the input field is cleared.
  void _submit() {
    final String text = _controller.text;
    if (text.isEmpty) {
      return;
    }
    widget.onAdd(text);
    _controller.clear();
  }

  /// Builds the UI for the input field and submit button.
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: "Enter a new todo",
              border: OutlineInputBorder(),
            ),
            onEditingComplete: _submit,
          ),
        ),
        TextButton(onPressed: _submit, child: Text("Add")),
      ],
    );
  }
}
