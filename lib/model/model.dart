/// Represents a single task in the to-do list.
/// Each task has a description and a completion status.
class TodoItem {
  bool _completed = false;
  final String _task;

  TodoItem({required String task}) : _task = task;

  /// Toggles the completion status of the task.
  void toggleCompleted() {
    _completed = !_completed;
  }

  /// Returns the description of the task.
  String get task {
    return _task;
  }

  /// Returns whether the task is completed.
  bool get completed {
    return _completed;
  }
}

/// Represents a list of to-do items with metadata.
/// Provides methods to manage the list and update metadata accordingly.
class TodoList {
  final TodoListMetadata _metadata = TodoListMetadata();
  final List<TodoItem> _list = [];

  /// Adds a new task to the to-do list.
  /// Updates the metadata after adding the task.
  void addItem(String task) {
    _list.add(TodoItem(task: task));
    _updateMetadata();
  }

  /// Removes a task from the to-do list by its index.
  /// Updates the metadata after removing the task.
  void removeItem(int index) {
    if (index < 0 || index >= _list.length) {
      return;
    }
    _list.removeAt(index);
    _updateMetadata();
  }

  /// Toggles the completion status of a task by its index.
  /// Updates the metadata after toggling the status.
  void toggleCompleted(int index) {
    if (index < 0 || index >= _list.length) {
      return;
    }
    _list[index].toggleCompleted();
    _updateMetadata();
  }

  /// Updates the metadata of the to-do list.
  void _updateMetadata() {
    _metadata.totalItems = _list.length;
    _metadata.totalCompleted = completedItems.length;
    _metadata.totalPending = pendingItems.length;
  }

  /// Returns a list of tasks that are not completed.
  List<TodoItem> get pendingItems {
    return _list.where((item) => !item.completed).toList();
  }

  /// Returns a list of tasks that are completed.
  List<TodoItem> get completedItems {
    return _list.where((item) => item.completed).toList();
  }

  /// Returns the metadata of the to-do list.
  TodoListMetadata get metadata => _metadata;

  /// Returns all tasks in the to-do list.
  List<TodoItem> get items => _list;

  /// Removes all completed tasks from the to-do list.
  /// Updates the metadata after clearing completed tasks.
  void clearCompleted() {
    _list.removeWhere((item) => item.completed);
    _updateMetadata();
  }

  /// Removes all tasks from the to-do list.
  /// Updates the metadata after clearing all tasks.
  void clearAll() {
    _list.clear();
    _updateMetadata();
  }
}

/// Represents metadata for a to-do list.
/// Tracks the total number of tasks, completed tasks, and pending tasks.
class TodoListMetadata {
  int totalItems = 0;
  int totalPending = 0;
  int totalCompleted = 0;
}
