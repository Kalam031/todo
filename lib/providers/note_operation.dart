import 'package:flutter/material.dart';
import 'package:todo/db/database_model.dart';
import 'package:todo/db/database_service.dart';

class NoteOperation extends ChangeNotifier {
  List<ToDoModel> _notes = [];

  List<ToDoModel> get getNotes {
    return _notes;
  }

  void addNewNote(String title, String description) {
    DatabaseService.instance.addToDoData(title, description);
    getNewNote();
  }

  void getNewNote() async {
    var todoData = await DatabaseService.instance.getToDoData();
    _notes = todoData;
    notifyListeners();
  }

  void deleteNote(int id) async {
    var todoData = await DatabaseService.instance.deleteToDoData(id);
    _notes = todoData;
    notifyListeners();
  }
}
