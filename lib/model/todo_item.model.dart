import 'package:flutter_aufgaben/model/todo_status.model.dart';
import 'package:flutter_aufgaben/services/postgre.service.dart';

/// Represents a single task in the to-do list.
/// Each task has a description and a completion status.
class TodoItem {
  /// The unique identifier for the task.
  final int id;

  /// The name of the task.
  String name;

  /// The status of the task.
  TodoStatus status;

  /// The deadline for the task.
  DateTime deadline;

  bool get isCompleted => status == TodoStatus.completed;
  bool get isFailed => status == TodoStatus.failed;
  bool get isPending => status == TodoStatus.pending;

  /// Toggles the status of the task between completed and pending.
  /// Returns the new status.
  Future<bool> toggleStatus() async {
    var didUpdate = false;
    if (isCompleted && !isFailed) {
      status = TodoStatus.pending;
      didUpdate = true;
    } else if (!isFailed) {
      status = TodoStatus.completed;
      didUpdate = true;
    }
    await PostgreService.updateTodo(
      id,
      name,
      TodoStatusExtension.toDBString(status),
      deadline,
    );
    return didUpdate;
  }

  /// Constructor for creating a new [TodoItem].
  TodoItem.forEdit({
    required this.name,
    required this.id,
    required this.status,
    required this.deadline,
  });

  /// Internal constructor for creating a [TodoItem].
  TodoItem._internal({
    required this.name,
    required this.id,
    this.status = TodoStatus.pending,
    DateTime? deadline,
  }) : deadline = deadline ?? DateTime.now();

  /// Factory constructor for creating a [TodoItem] from a Database query.
  factory TodoItem.fromDB(List<dynamic> query) {
    return TodoItem._internal(
      id: query[0],
      name: query[1],
      status: TodoStatusExtension.fromString(query[2]),
      deadline: query[3],
    );
  }
}
