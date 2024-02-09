import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../provider/notes_provider.dart';
import '../widgets/notes_card.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Note> bookmarkedNotes = Provider.of<NotesProvider>(context)
        .getNotes
        .where((note) =>
            Provider.of<NotesProvider>(context)
                .getBookmarkedNoteIds
                .contains(note.id) &&
            !note.deleted)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        leading: const Icon(
          Icons.bookmarks_outlined,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          'Bookmark Notes',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemCount: bookmarkedNotes.length,
        itemBuilder: (context, index) {
          return NotesCard(note: bookmarkedNotes[index]);
        },
      ),
    );
  }
}
