import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:notepad/src/features/notes/data/note_repository.dart';
import 'package:notepad/src/features/notes/domain/note_model.dart';

class EditScreen extends ConsumerStatefulWidget {
  final int index;
  final Note note;
  const EditScreen({super.key, required this.index, required this.note});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  late DateTime time;
  // final titleController = TextEditingController(text: widget.note.);
  // final bodyController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController(text: widget.note.title);
    bodyController = TextEditingController(text: widget.note.body);
    time = widget.note.time;
    super.initState();
  }

  //this getter is a boolean that checks if any changes has been made to the note title or body
  //if changes have been made, time stamp can be updated
  bool get isChanged =>
      widget.note.body != bodyController.text.trim() ||
      widget.note.title != titleController.text.trim();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(noteProvider).editNote(
              widget.index,
              titleController.text.trim(),
              bodyController.text.trim(),
              isChanged ? time = DateTime.now() : widget.note.time);
          if (isChanged){
            setState(() {
              time = DateTime.now();
            });
          }
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.done),
      ),
      appBar: AppBar(
        title: const Text("Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Time
              //Text(DateTime.now().toString()),
              Text(
                textAlign: TextAlign.start,
                DateFormat('d MMM yyyy HH:mm:ss a').format(time),
                style: const TextStyle(
                    fontSize: 15.3, fontWeight: FontWeight.w400),
              ),

              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              TextField(
                maxLines: 15,
                controller: bodyController,
                decoration: const InputDecoration(
                    hintText: 'Note something down',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
