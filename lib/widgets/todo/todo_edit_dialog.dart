import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/widgets/date_input.dart';

/// A widget that represents a dialog for editing a todo item.
///
/// Properties:
/// - [initialText]: The initial text to be displayed in the input field.
/// This attribute is required.
/// - [deadline]: The date associated with the todo item.
/// This attribute is required.
/// - [onSubmit]: A callback function to handle the submission of the edited text.
/// This attribute is required.
class TodoEditDialog extends StatefulWidget {
  /// The initial text to be displayed in the input field.
  final String initialText;

  /// The date associated with the todo item.
  final DateTime deadline;

  /// Callback function to handle the submission of the edited text.
  /// It takes the edited text and date as parameters.
  final Function(String, DateTime) onSubmit;

  const TodoEditDialog({
    super.key,
    required this.initialText,
    required this.deadline,
    required this.onSubmit,
  });

  @override
  State<TodoEditDialog> createState() => _TodoEditDialogState();
}

/// The state class for [TodoEditDialog].
class _TodoEditDialogState extends State<TodoEditDialog> {
  /// The controller for the text input field.
  final TextEditingController _controller = TextEditingController();

  /// The selected date for the todo item.
  DateTime _deadline = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialText;
    _deadline = widget.deadline;
  }

  /// Submits the edited text and date to the parent widget.
  void _submit() {
    final String text = _controller.text;
    if (text.isEmpty) {
      return;
    }
    widget.onSubmit(text, _deadline);
    _close();
  }

  /// Closes the dialog.
  void _close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Todo"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: "Edit your todo"),
          ),
          DateInput(
            onChange: (date) {
              setState(() {
                _deadline = date;
              });
            },
            date: _deadline,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: _close, child: const Text("Cancel")),
        ElevatedButton(onPressed: _submit, child: const Text("Save")),
      ],
    );
  }
}
