import 'package:flutter_aufgaben/model/todo_item.model.dart';
import 'package:flutter_aufgaben/model/todo_metadata.model.dart';

/// Represents a list of to-do items with metadata.
/// Provides methods to manage the list and update metadata accordingly.
class TodoList {
  TodoListMetadata _metadata = TodoListMetadata();
  List<TodoItem> _list = [];

  /// Default constructor for TodoList. Here for the fromJson factory constructor.
  TodoList();

  /// Adds a new task to the to-do list.
  /// Updates the metadata after adding the task.
  void addItem(String name, DateTime? deadline) {
    var id = 0;
    for (var item in _list) {
      if (id == item.id || id > item.id) {
        id++;
      }
    }
    _list.add(TodoItem(name: name, id: id, deadline: deadline));
    _updateMetadata();
  }

  /// Removes a task from the to-do list by its index.
  /// Updates the metadata after removing the task.
  void removeItem(int id) {
    _list.removeWhere((item) => item.id == id);
    _updateMetadata();
  }

  /// Toggles the completion status of a task by its index.
  /// Updates the metadata after toggling the status.
  void toggleCompleted(int id) {
    final item = _list.firstWhere((item) => item.id == id);
    item.toggleCompleted();
    _updateMetadata();
  }

  /// Updates the metadata of the to-do list.
  void _updateMetadata() {
    _checkFailedItems();
    _metadata.totalItems = _list.length;
    _metadata.totalCompleted = completedItems.length;
    _metadata.totalPending = pendingItems.length;
    _metadata.totalFailed = failedItems.length;
  }

  /// Returns a list of tasks that are not completed.
  List<TodoItem> get pendingItems {
    return _list.where((item) => item.isPending).toList();
  }

  /// Returns a list of tasks that are completed.
  List<TodoItem> get completedItems {
    return _list.where((item) => item.isCompleted).toList();
  }

  /// Returns a list of tasks that are failed.
  List<TodoItem> get failedItems {
    return _list.where((item) => item.isFailed).toList();
  }

  /// Returns the metadata of the to-do list.
  TodoListMetadata get metadata => _metadata;

  /// Returns all tasks in the to-do list.
  List<TodoItem> get items => _list;

  /// Removes all completed tasks from the to-do list.
  /// Updates the metadata after clearing completed tasks.
  void clearCompleted() {
    _list.removeWhere((item) => item.isCompleted);
    _updateMetadata();
  }

  /// Removes all tasks from the to-do list.
  /// Updates the metadata after clearing all tasks.
  void clearAll() {
    _list.clear();
    _updateMetadata();
  }

  /// Edits an existing task in the to-do list.
  /// Updates the metadata after editing the task.
  void editItem(TodoItem item) {
    final index = _list.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _list[index] = item;
      _updateMetadata();
    }
  }

  /// Checks for failed items in the to-do list.
  /// Updates the metadata after checking for failed items.
  void _checkFailedItems() {
    for (var item in _list) {
      item.checkFailedDeadline();
    }
  }

  /// Factory constructor to create a TodoList from JSON data.
  factory TodoList.fromJson(Map<String, dynamic> json) {
    final todoList = TodoList();
    final metadata = TodoListMetadata.fromJson(
      json["metadata"] as Map<String, dynamic>,
    );
    todoList._metadata = metadata;

    final items =
        (json["items"] as List<dynamic>)
            .map((item) => TodoItem.fromJson(item as Map<String, dynamic>))
            .toList();
    todoList._list = items;

    return todoList;
  }

  /// Converts the TodoList to JSON format.
  Map<String, dynamic> toJson() {
    return {
      "metadata": _metadata.toJson(),
      "items": _list.map((item) => item.toJson()).toList(),
    };
  }
}
