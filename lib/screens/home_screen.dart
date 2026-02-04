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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text("Flutter Notes"),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search notes',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ),
    ),
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
    // note object is already modified inside NoteView; this forces HomeScreen to rebuild.
    setState(() {});
  }

  void onNoteDeleted(int index){
    notes.removeAt(index);
    setState(() {});
  }
}