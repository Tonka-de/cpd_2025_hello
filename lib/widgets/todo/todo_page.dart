import 'package:flutter/widgets.dart';
import 'package:flutter_aufgaben/model/todo_item.model.dart';
import 'package:flutter_aufgaben/model/todo_list.model.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_input.dart';
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
  Future<void> _addItem(String text, DateTime date) async {
    await todoList.addItem(text, date);
    setState(() {
      todoList = todoList;
    });
  }

  /// Removes an item from the todo list by its index.
  /// Updates the UI after removing the item.
  Future<void> _removeItem(int index) async {
    await todoList.removeItem(index);
    setState(() {
      todoList = todoList;
    });
  }

  /// Toggles the completion status of an item by its index.
  /// Updates the UI after toggling the item's status.
  Future<void> _toggleItem(int index) async {
    await todoList.toggleCompleted(index);
    setState(() {
      todoList = todoList;
    });
  }

  /// Edits an existing item in the todo list.
  /// Updates the UI after editing the item.
  Future<void> _editItem(TodoItem item) async {
    await todoList.editItem(item);
    setState(() {
      todoList = todoList;
    });
  }

  Future<void> _loadTodos() async {
    await todoList.loadTodos();
    setState(() {
      todoList = todoList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        spacing: 8.0,
        children: [
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
