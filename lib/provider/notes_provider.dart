import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/note.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  Set<String> bookmarkedNoteIds = {};

  List<Note> get getNotes {
    return _notes;
  }

  Set<String> get getBookmarkedNoteIds {
    return bookmarkedNoteIds;
  }

  void addNewNote(Note note) {
    _notes.add(note);
    _saveNotesToSharedPreferences();
    notifyListeners();
  }

  void _saveNotesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> notesStringList = _notes
        .where((note) => !note.deleted)
        .map((note) => jsonEncode(note.toJson()))
        .toList();

    prefs.setStringList('notes', notesStringList);
  }

  void loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesStringList = prefs.getStringList('notes');
    if (notesStringList != null && notesStringList.isNotEmpty) {
      List<Note> decodedNotes = notesStringList.map((noteJson) {
        return Note.fromJson(jsonDecode(noteJson));
      }).toList();

      _notes.clear();
      _notes.addAll(decodedNotes);

      notifyListeners();
    }

    Set<String>? bookmarkedNoteIdsSet =
        prefs.getStringList('bookmarkedNoteIds')?.toSet();
    if (bookmarkedNoteIdsSet != null) {
      bookmarkedNoteIds = bookmarkedNoteIdsSet;
      notifyListeners();
    }
  }

  void _saveBookmarkedNoteIdsToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('bookmarkedNoteIds', bookmarkedNoteIds.toList());
  }

  void deleteNote(String id) {
    _notes.removeWhere((element) => element.id == id);
    _saveNotesToSharedPreferences();
    notifyListeners();
  }

  void editNote(Note note) {
    final myNote = _notes.firstWhere((item) => item.id == note.id);
    myNote.title = note.title;
    myNote.content = note.content;
    _saveNotesToSharedPreferences();
    notifyListeners();
  }

  void toggleShowAllText(Note note) {
    final noteIndex = _notes.indexWhere((item) => item.id == note.id);
    if (noteIndex != -1) {
      _notes[noteIndex].isExpanded = !_notes[noteIndex].isExpanded;
      notifyListeners();
    }
  }

  void bookmarkNote(String noteId) {
    if (bookmarkedNoteIds.contains(noteId)) {
      bookmarkedNoteIds.remove(noteId);
    } else {
      bookmarkedNoteIds.add(noteId);
    }
    _saveBookmarkedNoteIdsToSharedPreferences();
    notifyListeners();
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
