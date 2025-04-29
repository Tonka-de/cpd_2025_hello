import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_aufgaben/model/todo_list.model.dart';

/// Loads a TodoList from a JSON file.
///
/// Prompts the user to select a file.
/// If the user selects a file, it reads the content of the file,
/// parses the JSON data, and returns a TodoList object.
///
/// Returns a [Future] that completes with the loaded [TodoList].
///
/// Returns null if the user cancels the file picker or if the file does not exist.
Future<TodoList?> loadData() async {
  String? dir = await FilePicker.platform
      .pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: false,
      )
      .then((value) {
        if (value != null) {
          return value.files.first.path;
        } else {
          return null;
        }
      });

  if (dir != null) {
    var file = File(dir);

    if (await file.exists()) {
      var content = await file.readAsString();
      var json = jsonDecode(content);
      return TodoList.fromJson(json);
    }
  }
  return null;
}

/// Saves the TodoList to a JSON file.
///
/// Prompts the user to select a location to save the file.
/// If the user selects a location, the TodoList is serialized to JSON
/// and written to the specified file.
///
/// - [list] The [TodoList] to save.
///
/// Returns a [Future] that completes when the file is saved or the action was cancelled.
Future<void> saveData(TodoList list) async {
  String? dir = await FilePicker.platform
      .saveFile(dialogTitle: 'Save JSON file', fileName: 'todo_list.json')
      .then((value) {
        if (value != null) {
          return value;
        } else {
          return null;
        }
      });

  if (dir != null) {
    var file = File(dir);
    if (!await file.exists()) {
      await file.create();
    }
    await file.writeAsString(jsonEncode(list.toJson()));
  }
}
