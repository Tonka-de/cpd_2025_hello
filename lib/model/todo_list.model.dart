import 'package:flutter_aufgaben/model/todo_item.model.dart';
import 'package:flutter_aufgaben/model/todo_metadata.model.dart';
import 'package:flutter_aufgaben/model/todo_status.model.dart';
import 'package:flutter_aufgaben/services/postgre.service.dart';

/// Represents a list of to-do items with metadata.
/// Provides methods to manage the list and update metadata accordingly.
class TodoList {
  TodoListMetadata _metadata = TodoListMetadata();
  List<TodoItem> _list = [];

  Future<void> addItem(String name, DateTime date) async {
    PostgreService.addTodo(
      name,
      TodoStatusExtension.toDBString(TodoStatus.pending),
      date,
    );
    await loadTodos();
  }

  Future<void> removeItem(int id) async {
    PostgreService.deleteTodo(id);
    await loadTodos();
  }

  Future<void> toggleCompleted(int id) async {
    var didUpdate =
        await _list.firstWhere((item) => item.id == id).toggleStatus();
    if (didUpdate) {
      await loadTodos();
    }
  }

  Future<void> editItem(TodoItem item) async {
    PostgreService.updateTodo(
      item.id,
      item.name,
      TodoStatusExtension.toDBString(item.status),
      item.deadline,
    );
    await loadTodos();
  }

  get metadata => _metadata;
  get items => _list;

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

  Future<void> _makeMetadata() async {
    _metadata = TodoListMetadata(
      totalCompleted: _list.where((item) => item.isCompleted).length,
      totalFailed: _list.where((item) => item.isFailed).length,
      totalPending: _list.where((item) => item.isPending).length,
      totalItems: _list.length,
    );
  }

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
