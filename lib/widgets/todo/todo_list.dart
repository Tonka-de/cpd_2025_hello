import 'package:flutter/widgets.dart';
import 'package:flutter_aufgaben/model/model.dart';
import 'package:flutter_aufgaben/widgets/todo/todo_item.dart';

/// A widget that displays a list of todo items.
///
/// This widget is responsible for rendering a scrollable list of [TodoItem] instances.
///
/// Properties:
/// - [list]: A list of todo items to be displayed. Each item is an instance of [TodoItem].
/// This attribute is required.
/// - [onDelete]: A callback function triggered when a delete action is performed on a todo item.
/// It receives the index of the item to be deleted as a parameter.
/// This attribute is required.
/// - [onToggle]: A callback function triggered when a toggle action is performed on a todo item.
/// It receives the index of the item to be toggled as a parameter.
/// This attribute is required.
class TodoListWidget extends StatelessWidget {
  /// The list of todo items to be displayed.
  final List<TodoItem> list;

  /// Callback function to handle item deletion.
  /// It takes the index of the item to be deleted as a parameter.
  final void Function(int) onDelete;

  /// Callback function to handle item toggling.
  /// It takes the index of the item to be toggled as a parameter.
  final void Function(int) onToggle;

  const TodoListWidget({
    super.key,
    required this.list,
    required this.onDelete,
    required this.onToggle,
  });

  /// Generates a callback for handling the deletion of a todo item.
  ///
  /// This method wraps the [onDelete] callback to provide a [VoidCallback] that can be used in the UI.
  VoidCallback _handleDelete(int index) {
    return () {
      onDelete(index);
    };
  }

  /// Generates a callback for handling the toggling of a todo item.
  ///
  /// This method wraps the [onToggle] callback to provide a [VoidCallback] that can be used in the UI.
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
