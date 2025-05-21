import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/model/todo_item.model.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_edit_dialog.dart';

/// A widget that represents a single todo item.
///
/// This widget is responsible for displaying the [TodoItem].
///
/// Properties:
/// - [task]: The todo item to be displayed.
/// This attribute is required.
/// - [onDelete]: A callback function to handle the deletion of the todo item.
/// This attribute is required.
/// - [onToggle]: A callback function to handle toggling the completion status of the todo item.
/// This attribute is required.
/// - [onEdit]: A callback function to handle editing the todo item.
/// This attribute is required.
class TodoItemWidget extends StatelessWidget {
  /// The todo item to be displayed.
  final TodoItem task;

  /// Callback function to handle item deletion.
  /// It takes the id of the item to be deleted as a parameter.
  final Function(int) onDelete;

  /// Callback function to handle item toggling.
  /// It takes the id of the item to be toggled as a parameter.
  final Function(int) onToggle;

  /// Callback function to handle item editing.
  /// It takes a [TodoItem] as a parameter and returns void.
  final Function(TodoItem) onEdit;

  const TodoItemWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onToggle,
    required this.onEdit,
  });

  /// Generates a callback for handling the editing of a todo item.
  void _handleChange(String text, DateTime date) {
    if (text.isEmpty) {
      return;
    }
    onEdit(
      TodoItem.forEdit(
        id: task.id,
        name: text,
        status: task.status,
        deadline: date,
      ),
    );
  }

  /// Generates a color based on the status of the todo item.
  Color _getColor() {
    if (task.isCompleted) {
      return Colors.green;
    } else if (task.isFailed) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  /// Shows a dialog for editing the todo item.
  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TodoEditDialog(
          initialText: task.name,
          deadline: task.deadline,
          onSubmit: _handleChange,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color:
              task.isCompleted
                  ? Colors.green
                  : task.isFailed
                  ? Colors.red
                  : Colors.grey,
          width: 2,
        ),
      ),

      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (_) {
          onToggle(task.id);
        },
        activeColor: task.isFailed ? Colors.red : Colors.green,
        checkColor: Colors.white,
      ),

      textColor: _getColor(),
      iconColor: _getColor(),

      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          onDelete(task.id);
        },
        color: Colors.red,
      ),

      onTap: () {
        onToggle(task.id);
      },
      onLongPress: () {
        onDelete(task.id);
      },

      title: Row(
        children: [
          Expanded(
            child: Text(
              task.name,
              style: TextStyle(
                decoration:
                    task.isCompleted || task.isFailed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                decorationColor: task.isCompleted ? Colors.green : Colors.red,
                decorationThickness: 2,
              ),
              overflow: TextOverflow.ellipsis, // Prevents text overflow
            ),
          ),
          const SizedBox(
            width: 8,
          ), // Adds spacing between text and DateInput// Constrain DateInput width
          Text(
            task.deadline.toLocal().toString().split(' ')[0],
            style: TextStyle(color: task.isPending ? Colors.grey : null),
          ),
          const SizedBox(width: 32),
          IconButton(
            onPressed: () => _showEditDialog(context),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
