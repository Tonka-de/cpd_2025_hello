import 'package:flutter/widgets.dart';
import 'package:flutter_aufgaben/model/todo_item.model.dart';
import 'package:flutter_aufgaben/model/todo_list.model.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_input.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_json_buttons.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_list.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_metadata.dart';

/// A widget representing the main page of the Todo app.
///
/// It manages the state of the todo list and provides methods to add, remove, and toggle items.
/// It also contains the UI components for displaying the todo list, input field, and metadata.
class TodoPageWidget extends StatefulWidget {
  const TodoPageWidget({super.key});

  @override
  State<TodoPageWidget> createState() => _TodoPageWidgetState();
}

/// The state class for [TodoPageWidget].
class _TodoPageWidgetState extends State<TodoPageWidget> {
  var todoList = TodoList();

  /// Adds a new item to the todo list.
  /// Updates the UI after adding the item.
  void _addItem(String text, DateTime date) {
    setState(() {
      todoList.addItem(text, date);
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

  /// Edits an existing item in the todo list.
  /// Updates the UI after editing the item.
  void _editItem(TodoItem item) {
    setState(() {
      todoList.editItem(item);
    });
  }

  /// Imports a JSON string to update the todo list.
  /// Updates the UI after importing the JSON.
  void _importJson(TodoList? data) {
    if (data == null) {
      return;
    }
    setState(() {
      todoList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        spacing: 8.0,
        children: [
          TodoJsonButtons(onImport: _importJson, data: todoList),
          TodoMetadataWidget(metadata: todoList.metadata),
          TodoListWidget(
            list: todoList.items,
            onDelete: _removeItem,
            onToggle: _toggleItem,
            onEdit: _editItem,
          ),
          TodoInputWidget(onAdd: _addItem),
        ],
      ),
    );
  }
}
