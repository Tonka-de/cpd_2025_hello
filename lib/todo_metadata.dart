import 'package:flutter/widgets.dart';
import 'package:todo_app/model.dart';

/// A widget that displays metadata about the todo list.
/// It shows the total number of items, completed items, and pending items.
class TodoMetadataWidget extends StatelessWidget {
  /// The metadata to be displayed.
  /// This attribute is required and cannot be null.
  final TodoListMetadata metadata;

  const TodoMetadataWidget({super.key, required this.metadata});

  /// Builds the UI for displaying the metadata.
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Items: ${metadata.totalItems}"),
        Text("Completed: ${metadata.totalCompleted}"),
        Text("Pending: ${metadata.totalPending}"),
      ],
    );
  }
}
