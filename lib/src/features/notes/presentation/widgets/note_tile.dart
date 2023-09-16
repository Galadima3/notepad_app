
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad/src/features/notes/domain/note_model.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.note, required this.body, required this.title, required this.time,
  });

  final Note note;
  final String body;
  final String title;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15.5, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 3.95),
            Text(body),
            const SizedBox(height: 3.95),
            Text(
              DateFormat('d MMM yyyy HH:mm a')
                  .format(time),
              style:
                  const TextStyle(fontWeight: FontWeight.w300),
            )
          ],
        ),
      ),
    );
  }
}
