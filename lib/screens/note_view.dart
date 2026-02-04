import 'package:flutter/material.dart';
import 'package:notes_apppp/models/note_model.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    super.key,
    required this.note,
    required this.index,
    required this.onNoteDeleted,
  });

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _openEditDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onNoteDeleted(index);
              Navigator.of(context).pop(); // go back after delete
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                note.body,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditDialog(BuildContext context) {
    final titleController = TextEditingController(text: note.title);
    final bodyController = TextEditingController(text: note.body);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Note"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                maxLines: 8,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Save"),
            onPressed: () {
              note.title = titleController.text;
              note.body = bodyController.text;
              Navigator.pop(context); // close dialog
              Navigator.pop(context, true); // pop NoteView with 'updated' = true
            },
          ),
        ],
      ),
    );
  }
}
