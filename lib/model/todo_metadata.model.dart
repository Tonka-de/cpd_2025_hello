/// Represents metadata for a to-do list.
/// Tracks the total number of tasks, completed tasks, and pending tasks.
class TodoListMetadata {
  /// The total number of items in the to-do list.
  int totalItems;

  /// The total number of pending items in the to-do list.
  int totalPending;

  /// The total number of completed items in the to-do list.
  int totalCompleted;

  /// The total number of failed items in the to-do list.
  int totalFailed;

  TodoListMetadata({
    this.totalItems = 0,
    this.totalPending = 0,
    this.totalCompleted = 0,
    this.totalFailed = 0,
  });

  /// Factory constructor to create a TodoListMetadata from JSON data.
  factory TodoListMetadata.fromJson(Map<String, dynamic> json) {
    return TodoListMetadata(
      totalItems: json['totalItems'] as int,
      totalPending: json['totalPending'] as int,
      totalCompleted: json['totalCompleted'] as int,
      totalFailed: json['totalFailed'] as int,
    );
  }

  /// Converts the TodoListMetadata to JSON format.
  Map<String, int> toJson() {
    return {
      'totalItems': totalItems,
      'totalPending': totalPending,
      'totalCompleted': totalCompleted,
      'totalFailed': totalFailed,
    };
  }
}
