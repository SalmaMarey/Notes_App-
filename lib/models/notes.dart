import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NotesOperation extends ChangeNotifier {
  final List<Note> _notes = [];
  List<Note> get getNotes {
    return _notes;
  }

  // NotesOperation() {
  //   addNewNote(1,'first note', 'aaaaaa', DateTime(2023),);
  // }
  void addNewNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
