import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screens/saved_screen.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NotesProvider>(
        builder: (context, pageProvider, child) {
          return IndexedStack(
            index: pageProvider.currentIndex,
            children: const [
              HomeScreen(),
              SavedPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<NotesProvider>(
        builder: (context, pageProvider, child) {
          return BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 25, 25, 25),
            currentIndex: pageProvider.currentIndex,
            onTap: (index) {
              context.read<NotesProvider>().setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark,
                ),
                label: 'Bookmark',
              ),
            ],
          );
        },
      ),
    );
  }
}
