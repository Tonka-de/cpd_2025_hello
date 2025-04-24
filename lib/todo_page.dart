import 'package:flutter/widgets.dart';
import 'package:todo_app/model.dart';
import 'package:todo_app/todo_input.dart';
import 'package:todo_app/todo_list.dart';
import 'package:todo_app/todo_metadata.dart';

/// A widget representing the main page of the Todo app.
/// It manages the state of the todo list and provides methods to add, remove, and toggle items.
class TodoPageWidget extends StatefulWidget {
  const TodoPageWidget({super.key});

  @override
  State<TodoPageWidget> createState() => _TodoPageWidgetState();
}

/// The state class for [TodoPageWidget].
/// It contains the logic for managing the todo list and updating the UI.
class _TodoPageWidgetState extends State<TodoPageWidget> {
  final todoList = TodoList();

  /// Adds a new item to the todo list.
  /// Updates the UI after adding the item.
  void _addItem(String text) {
    setState(() {
      todoList.addItem(text);
    });
  }

  /// Removes an item from the todo list by its index.
  /// Updates the UI after removing the item.
  void _removeItem(int index) {
    setState(() {
      todoList.removeItem(index);
    });
  }

  /// Toggles the completion status of an item by its index.
  /// Updates the UI after toggling the item's status.
  void _toggleItem(int index) {
    setState(() {
      todoList.toggleCompleted(index);
    });
  }

  /// Builds the UI for the Todo page.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        spacing: 8.0,
        children: [
          TodoMetadataWidget(metadata: todoList.metadata),
          TodoInputWidget(onAdd: _addItem),
          TodoListWidget(
            list: todoList.items,
            onDelete: _removeItem,
            onToggle: _toggleItem,
          ),
        ],
      ),
    );
  }
}
