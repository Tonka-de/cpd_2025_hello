import 'package:flutter/widgets.dart';
import 'package:todo_app/model.dart';
import 'package:todo_app/todo_item.dart';

/// A widget that displays a list of todo items.
/// It provides functionality to delete and toggle items.
class TodoListWidget extends StatelessWidget {
  /// The list of todo items to be displayed.
  /// This attribute is required and cannot be null.
  final List<TodoItem> list;

  /// Callback function to handle item deletion.
  /// It takes the index of the item to be deleted.
  /// This attribute is required and cannot be null.
  final void Function(int) onDelete;

  /// Callback function to handle item toggling.
  /// It takes the index of the item to be toggled.
  /// This attribute is required and cannot be null.
  final void Function(int) onToggle;

  const TodoListWidget({
    super.key,
    required this.list,
    required this.onDelete,
    required this.onToggle,
  });

  VoidCallback _handleDelete(int index) {
    return () {
      onDelete(index);
    };
  }

  VoidCallback _handleToggle(int index) {
    return () {
      onToggle(index);
    };
  }

  /// Builds the UI for the todo list.
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: list.length,
        itemBuilder:
            (context, index) => TodoItemWidget(
              task: list[index],
              onDelete: _handleDelete(index),
              onToggle: _handleToggle(index),
            ),
        separatorBuilder: (context, index) => Container(height: 8),
      ),
    );
  }
}
