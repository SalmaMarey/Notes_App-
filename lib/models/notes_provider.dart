import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  List<Note> get getNotes {
    return _notes;
  }

  // NotesProvider() {
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

  // void editNote(String id, String title, String content) {
  void editNote(Note note) {
    print(_notes);
    final myNote = _notes.firstWhere((item) => item.id == note.id);
    myNote.title = note.title;
    myNote.content = note.content;
    notifyListeners();
  }
}
