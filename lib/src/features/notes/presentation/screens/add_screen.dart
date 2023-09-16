import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notepad/src/features/notes/data/note_repository.dart';


class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(noteProvider).addNote(
            titleController.text.trim(),
            bodyController.text.trim(),
            DateTime.now()),
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
                DateFormat('d MMM yyyy HH:mm:ss a').format(DateTime.now()),
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
