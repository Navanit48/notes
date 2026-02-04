import 'package:flutter/material.dart';
import 'package:notes_apppp/models/note_model.dart';
import 'package:notes_apppp/screens/create_note.dart';
import 'package:notes_apppp/screens/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = List.empty(growable: true);
  String searchText = "";
  bool isSearching = false; // added

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // show TextField in place of title when searching
        title: isSearching
            ? TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search notes',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
              )
            : const Text("Flutter Notes"),
        actions: [
          if (isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isSearching = false;
                  searchText = "";
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
        ],
      ),

      body: Builder(
        builder: (context) {
          final filteredNotes = notes
              .where((n) =>
                  n.title.toLowerCase().contains(searchText.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              final displayedNote = filteredNotes[index];
              final originalIndex = notes.indexOf(displayedNote);

              return NoteCard(
                note: displayedNote,
                index: originalIndex,
                onNoteDeleted: onNoteDeleted,
                onNoteUpdated: onNoteUpdated,
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateNote(onNewNoteCreated: onNewNoteCreated,)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void onNewNoteCreated(Note note){
    notes.add(note);
    setState(() {});
  }

  void onNoteUpdated(int index) {
    setState(() {});
  }

  void onNoteDeleted(int index){
    notes.removeAt(index);
    setState(() {});
  }
}