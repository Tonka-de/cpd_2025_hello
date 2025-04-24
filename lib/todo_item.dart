import 'package:flutter/material.dart';
import 'package:todo_app/model.dart';

/// A widget that represents a single todo item.
/// It displays the task description and provides options to delete or toggle the task.
class TodoItemWidget extends StatelessWidget {
  /// The todo item to be displayed.
  /// This attribute is required and cannot be null.
  final TodoItem task;

  /// Callback function to handle item deletion.
  /// It takes no parameters and returns void.
  /// This attribute is required and cannot be null.
  final VoidCallback onDelete;

  /// Callback function to handle item toggling.
  /// It takes no parameters and returns void.
  /// This attribute is required and cannot be null.
  final VoidCallback onToggle;

  const TodoItemWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
  });

  /// Builds the UI for the todo item.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.task,
        style: TextStyle(
          decoration:
              task.completed ? TextDecoration.lineThrough : TextDecoration.none,
          decorationColor: Colors.green,
          decorationThickness: 2,
        ),
      ),
      trailing: IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
      leading: Checkbox(
        value: task.completed,
        onChanged: (value) {
          onToggle();
        },
        activeColor: Colors.green,
        checkColor: Colors.white,
      ),
      onTap: onToggle,
      onLongPress: onDelete,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: task.completed ? Colors.green : Colors.grey,
          width: 2,
        ),
      ),
      selectedTileColor: Colors.green.withAlpha(50),
      selectedColor: Colors.green,
      selected: task.completed,
    );
  }
}
