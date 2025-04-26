import 'package:flutter/widgets.dart';
import 'package:flutter_aufgaben/model/model.dart';

/// A widget that displays metadata about the todo list.
///
/// It displays the [TodoListMetadata].
///
/// Properties:
/// - [metadata]: The metadata to be displayed.
/// This attribute is required.
class TodoMetadataWidget extends StatelessWidget {
  /// The metadata to be displayed.
  final TodoListMetadata metadata;

  const TodoMetadataWidget({super.key, required this.metadata});

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
