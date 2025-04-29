import 'package:flutter_aufgaben/model/todo_status.model.dart';

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

  TodoItem({
    required this.name,
    required this.id,
    this.status = TodoStatus.pending,
    DateTime? deadline,
  }) : deadline = deadline ?? DateTime.now();

  /// Toggles the completion status of the task.
  void toggleCompleted() {
    if (status == TodoStatus.failed) {
      return;
    }
    if (status == TodoStatus.pending) {
      status = TodoStatus.completed;
    } else {
      status = TodoStatus.pending;
    }
  }

  /// Check if the task is failed based on the deadline.
  void checkFailedDeadline() {
    if (isCompleted) {
      return;
    }
    var temp = deadline.copyWith(hour: 23, minute: 59, second: 59);
    if (DateTime.now().isAfter(temp)) {
      status = TodoStatus.failed;
    }
  }

  /// Sets the task as failed.
  void setFailed() {
    status = TodoStatus.failed;
  }

  /// Returns whether the task is completed.
  bool get isCompleted {
    return status == TodoStatus.completed;
  }

  /// Returns whether the task is failed.
  bool get isFailed {
    return status == TodoStatus.failed;
  }

  /// Returns whether the task is pending.
  bool get isPending {
    return status == TodoStatus.pending;
  }

  /// Factory constructor to create a TodoItem from JSON data.
  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'] as int,
      name: json['name'] as String,
      status: TodoStatusExtension.fromString(json['status'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
    );
  }

  /// Converts the TodoItem to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': TodoStatusExtension.toJson(status),
      'deadline': deadline.toIso8601String(),
    };
  }
}
