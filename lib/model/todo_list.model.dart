import 'package:flutter_aufgaben/model/todo_item.model.dart';
import 'package:flutter_aufgaben/model/todo_metadata.model.dart';
import 'package:flutter_aufgaben/model/todo_status.model.dart';
import 'package:flutter_aufgaben/services/postgre.service.dart';

/// A class that manages a list of to-do items and their associated metadata.
///
/// Provides methods to add, remove, edit, and toggle the completion status of to-do items.
/// Interacts with a PostgreSQL database for persistent storage and updates the metadata
/// after each operation. Also checks for failed to-dos based on their deadlines.
class TodoList {
  /// Metadata about the to-do list, such as counts of completed, failed, and pending items.
  TodoListMetadata _metadata = TodoListMetadata();

  /// The internal list of to-do items.
  List<TodoItem> _list = [];

  /// Adds a new to-do item to the list and database.
  ///
  /// [name] - The name or description of the to-do item.
  /// [date] - The deadline for the to-do item.
  ///
  /// After adding, reloads the list from the database.
  Future<void> addItem(String name, DateTime date) async {
    PostgreService.addTodo(
      name,
      TodoStatusExtension.toDBString(TodoStatus.pending),
      date,
    );
    await loadTodos();
  }

  /// Removes a to-do item from the list and database by its [id].
  ///
  /// After removing, reloads the list from the database.
  Future<void> removeItem(int id) async {
    PostgreService.deleteTodo(id);
    await loadTodos();
  }

  /// Toggles the completion status of a to-do item by its [id].
  ///
  /// If the status changes, reloads the list from the database.
  Future<void> toggleCompleted(int id) async {
    var didUpdate =
        await _list.firstWhere((item) => item.id == id).toggleStatus();
    if (didUpdate) {
      await loadTodos();
    }
  }

  /// Edits an existing to-do item in the list and database.
  ///
  /// [item] - The updated to-do item.
  ///
  /// After editing, reloads the list from the database.
  Future<void> editItem(TodoItem item) async {
    PostgreService.updateTodo(
      item.id,
      item.name,
      TodoStatusExtension.toDBString(item.status),
      item.deadline,
    );
    await loadTodos();
  }

  /// Returns the current metadata for the to-do list.
  get metadata => _metadata;

  /// Returns the current list of to-do items.
  get items => _list;

  /// Checks all to-do items for failed status based on their deadlines.
  ///
  /// If a to-do's deadline has passed and it is not marked as failed, updates its status to failed.
  /// If a to-do is marked as failed but its deadline is now in the future, resets its status to pending.
  /// Returns true if any updates were made.
  Future<bool> _checkFailed() async {
    var didUpdate = false;
    for (var item in _list) {
      final utc = DateTime.now().toUtc();
      if (item.deadline.isBefore(utc) && !item.isFailed) {
        item.status = TodoStatus.failed;
        didUpdate = true;
        await PostgreService.updateTodo(
          item.id,
          item.name,
          TodoStatusExtension.toDBString(item.status),
          item.deadline,
        );
      } else if (item.isFailed && item.deadline.isAfter(utc)) {
        item.status = TodoStatus.pending;
        didUpdate = true;
        await PostgreService.updateTodo(
          item.id,
          item.name,
          TodoStatusExtension.toDBString(item.status),
          item.deadline,
        );
      }
    }
    return didUpdate;
  }

  /// Updates the metadata for the to-do list based on the current items.
  Future<void> _makeMetadata() async {
    _metadata = TodoListMetadata(
      totalCompleted: _list.where((item) => item.isCompleted).length,
      totalFailed: _list.where((item) => item.isFailed).length,
      totalPending: _list.where((item) => item.isPending).length,
      totalItems: _list.length,
    );
  }

  /// Loads all to-do items from the database, checks for failed items, sorts them,
  /// and updates the metadata.
  Future<void> loadTodos() async {
    final result = await PostgreService.loadTodos();
    _list =
        result.map((row) {
          return TodoItem.fromDB(row);
        }).toList();
    if (await _checkFailed()) {
      final result = await PostgreService.loadTodos();
      _list =
          result.map((row) {
            return TodoItem.fromDB(row);
          }).toList();
    }
    _list.sort((a, b) {
      final compare = a.deadline.compareTo(b.deadline);
      if (compare == 0) {
        return a.id.compareTo(b.id);
      }
      return compare;
    });
    await _makeMetadata();
  }
}
