import 'package:flutter/widgets.dart';
import 'package:flutter_aufgaben/model/todo_item.model.dart';
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
  /// It takes the id of the item to be deleted as a parameter.
  final void Function(int) onDelete;

  /// Callback function to handle item toggling.
  /// It takes the id of the item to be toggled as a parameter.
  final void Function(int) onToggle;

  /// Callback function to handle item editing.
  /// It takes the [TodoItem] to be edited as a parameter.
  final void Function(TodoItem) onEdit;

  const TodoListWidget({
    super.key,
    required this.list,
    required this.onDelete,
    required this.onToggle,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: list.length,
        itemBuilder:
            (context, index) => TodoItemWidget(
              task: list[index],
              onDelete: onDelete,
              onToggle: onToggle,
              onEdit: onEdit,
            ),
        separatorBuilder: (context, index) => Container(height: 8),
      ),
    );
  }
}
