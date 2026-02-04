import 'package:flutter/material.dart';
import 'package:notes_apppp/models/note_model.dart';
import 'package:notes_apppp/screens/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onNoteDeleted,
    required this.index,
    required this.onNoteUpdated, // added
  });

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;
  final Function(int) onNoteUpdated; // added

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          final updated = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (context) => NoteView(
                note: note,
                index: index,
                onNoteDeleted: onNoteDeleted,
              ),
            ),
          );
          if (updated == true) {
            onNoteUpdated(index); // notify HomeScreen to refresh
          }
        },
        title: Text(
          note.title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          note.body,
          style: const TextStyle(
            fontSize: 20,
          ),
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}