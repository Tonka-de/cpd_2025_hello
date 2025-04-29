/// Represents the status of a to-do item.
enum TodoStatus { pending, completed, failed }

/// Extension to convert TodoStatus enum to string and vice versa.
extension TodoStatusExtension on TodoStatus {
  /// Converts the TodoStatus enum to a string representation.
  static String toJson(TodoStatus status) {
    switch (status) {
      case TodoStatus.pending:
        return 'Pending';
      case TodoStatus.completed:
        return 'Completed';
      case TodoStatus.failed:
        return 'Failed';
    }
  }

  /// Converts a string representation to the corresponding TodoStatus enum.
  static TodoStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return TodoStatus.completed;
      case 'failed':
        return TodoStatus.failed;
      default:
        return TodoStatus.pending;
    }
  }
}
