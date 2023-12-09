import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

import '../screens/edit_note.dart';

class NotesCard extends StatefulWidget {
  const NotesCard({super.key, required this.note});
  final Note note;

  @override
  State<NotesCard> createState() => _NotesCardState();
}

class _NotesCardState extends State<NotesCard> {
  final List<Color> circleColors = [
    const Color.fromARGB(255, 114, 78, 120),
    Colors.blue,
    const Color.fromARGB(255, 112, 128, 65),
    const Color.fromARGB(255, 120, 78, 78),
    const Color.fromARGB(255, 105, 105, 105),
  ];

  Color randomGenerator() {
    return circleColors[Random().nextInt(5)];
  }

  String tilteText = '';
  String id = '';
  String contentText = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const EditNote()));
        },
        child: Card(
          color: randomGenerator(),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.note.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 180,
                  ),
                  const Icon(
                    Icons.bookmark,
                    size: 30,
                    color: Colors.yellow,
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(widget.note.content),
              subtitle: Text(widget.note.formattedDate),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_sweep,
                  size: 30,
                  color: Color.fromARGB(255, 48, 48, 48),
                ),
                onPressed: () {
                  // Provider.of<Note>(context, listen: false).deleteNote(id);
                  // Navigator.pop(context);

                  Provider.of<Note>(context, listen: false).deleteNote(id);
                  Navigator.pop(context);
                },
              ),
            ),
            const Icon(
              Icons.expand_more,
              color: Colors.black,
              size: 25,
            ),
          ]),
        ));
  }
}
