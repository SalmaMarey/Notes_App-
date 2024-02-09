import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/screens/tab_screen.dart';

import 'package:provider/provider.dart';

import '../provider/notes_provider.dart';
import 'home.dart';

class AddNote extends StatefulWidget {
  const AddNote({
    super.key,
  });

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String tilteText = '';

  String contentText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 161, 144, 92),
            ),
            onPressed: () {
              context.read<NotesProvider>().addNewNote(
                    Note(
                      content: contentText,
                      title: tilteText,
                      date: DateTime.now(),
                      id: uuid.v4(),
                    ),
                  );
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => const TabScreen()),
                ),
              );
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 365,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Tilte',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          tilteText = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 365,
                  height: 900,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter Content',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      contentText = value;
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
