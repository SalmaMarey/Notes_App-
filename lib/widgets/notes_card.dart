import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';

import 'package:notes_app/screens/edit_note.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({super.key, required this.note});
  final Note note;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  final List<Color> circleColors = [
    const Color.fromARGB(255, 197, 107, 89),
    Colors.blue,
    const Color.fromARGB(255, 3, 83, 108),
    const Color.fromARGB(255, 149, 57, 77),
    const Color.fromARGB(255, 105, 105, 105),
  ];

  Color randomGenerator() {
    return circleColors[Random().nextInt(5)];
  }

  String tilteText = '';

  String contentText = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => EditNote(note: widget.note)));
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Card(
            color: randomGenerator(),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      widget.note.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    // const SizedBox(
                    //   width: 180,
                    // ),
                    IconButton(
                      onPressed: () {
                        Provider.of<NotesProvider>(context, listen: false)
                            .bookmarkNote(widget.note.id);
                      },
                      icon: Provider.of<NotesProvider>(context)
                              .getBookmarkedNoteIds
                              .contains(widget.note.id)
                          ? const Icon(
                              Icons.bookmark,
                              size: 30,
                              color: Colors.yellow,
                            )
                          : const Icon(
                              Icons.bookmark_add_outlined,
                              size: 30,
                              color: Color.fromARGB(255, 48, 48, 48),
                            ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Consumer<NotesProvider>(
                  builder: (context, notesProvider, child) {
                    final content = widget.note.content;

                    final displayedContent = widget.note.isExpanded
                        ? content
                        : content.length >= 50
                            ? '${content.substring(0, 50)}...'
                            : content;

                    return Text(displayedContent);
                  },
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 56),
                  child: Center(
                    child: Text(
                      widget.note.formattedDate,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_sweep,
                    size: 30,
                    color: Color.fromARGB(255, 48, 48, 48),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Welcome"),
                        content: const Text(
                            "Do you really want to delete this note?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: Row(children: [
                              Consumer<NotesProvider>(
                                builder: (context, notesProvider, _) {
                                  return InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color.fromARGB(
                                            255, 161, 144, 92),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        "Yes, I'm sure",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      notesProvider.deleteNote(widget.note.id);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 53,
                              ),
                              InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 161, 144, 92),
                                  ),
                                  child: const Text(
                                    "Cancel ",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: Consumer<NotesProvider>(
                  builder: (context, notesProvider, child) {
                    return Icon(
                      widget.note.isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: const Color.fromARGB(255, 48, 48, 48),
                    );
                  },
                ),
                onPressed: () {
                  Provider.of<NotesProvider>(context, listen: false)
                      .toggleShowAllText(widget.note);
                },
              ),
            ]),
          ),
        ));
  }
}
