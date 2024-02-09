import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../provider/notes_provider.dart';
import 'home.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, required this.note});
  final Note note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  String tilteText = '';

  String contentText = '';

  late TextEditingController _titlecontroller;
  late TextEditingController _contentcontroller;
  @override
  void initState() {
    super.initState();

    _titlecontroller = TextEditingController(text: widget.note.title);
    _contentcontroller = TextEditingController(text: widget.note.content);
  }

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
          IconButton(
            icon: const Icon(
              Icons.edit_note_outlined,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 161, 144, 92),
              ),
              onPressed: () {
                Provider.of<NotesProvider>(context, listen: false).editNote(
                  Note(
                      content: _contentcontroller.text,
                      title: _titlecontroller.text,
                      date: DateTime.now(),
                      id: widget.note.id),
                );

                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
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
                        controller: _titlecontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
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
                    controller: _contentcontroller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      // label: Text(widget.note.content),
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
