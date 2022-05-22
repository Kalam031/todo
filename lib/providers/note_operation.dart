import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteOperation extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NoteOperation() {
    _addNewNote(
      'Untitled Note',
      'This is an empty note.',
    );
  }

  void _addNewNote(String title, String description) {
    Note note = Note(title, description);
    _notes.add(note);
    notifyListeners();
  }
}
