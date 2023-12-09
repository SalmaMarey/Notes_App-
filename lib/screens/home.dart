import 'package:flutter/material.dart';

import 'package:notes_app/screens/add_note.dart';

import 'package:provider/provider.dart';

import '../models/notes.dart';
import '../widgets/notes_card.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        leading: const Icon(
          Icons.dashboard_outlined,
          size: 30,
          color: Colors.white,
        ),
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        actions: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: const Color.fromARGB(126, 55, 55, 55),
                borderRadius: BorderRadius.circular(13)),
            child: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[200],
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const AddNote()));
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      body: Consumer<NotesOperation>(
          builder: (context, NotesOperation data, child) {
        return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return NotesCard(
                note: data.getNotes[index],
              );
            });
      }),
    );
  }
}
