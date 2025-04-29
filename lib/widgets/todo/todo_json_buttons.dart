import 'package:flutter/material.dart';
import 'package:flutter_aufgaben/model/todo_list.model.dart';
import 'package:flutter_aufgaben/utils/read_file.dart';

/// A widget that provides buttons for exporting and importing a TodoList.
///
/// Properties:
/// - [onImport]: A callback function to handle the import action.
/// This attribute is required.
/// - [data]: The TodoList data to be exported.
/// This attribute is required.
class TodoJsonButtons extends StatelessWidget {
  /// Callback function to handle JSON import.
  final Function(TodoList?) onImport;

  /// The data to save.
  final TodoList data;

  const TodoJsonButtons({
    super.key,
    required this.onImport,
    required this.data,
  });

  /// Handles the export action.
  Future<void> _handleExport() async {
    saveData(data);
  }

  /// Handles the import action.
  Future<void> _handleImport() async {
    var importData = await loadData();
    onImport(importData);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 16,
      children: [
        ElevatedButton(onPressed: _handleExport, child: const Text("Export")),
        ElevatedButton(onPressed: _handleImport, child: const Text("Import")),
      ],
    );
  }
}
