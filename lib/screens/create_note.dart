import 'package:flutter/material.dart';
import 'package:notes_apppp/models/note_model.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title"
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: bodyController,
              style: const TextStyle(
                fontSize: 18
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your Story"
              ),
              maxLines: 10,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(titleController.text.isEmpty){
            return;
          }
          if(bodyController.text.isEmpty){
            return;
          }

          final note = Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: titleController.text,
            body: bodyController.text,
          );

          widget.onNewNoteCreated(note);
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}