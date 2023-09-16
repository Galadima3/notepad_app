import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:notepad/src/features/notes/domain/note_model.dart';

class NoteRepository {
  final Box<Note> _noteBox;

  NoteRepository(this._noteBox);

  Future<void> addNote(String title, String body, DateTime time, ) async {
    final newNote = Note(title: title, body: body, time: time);
    await _noteBox.add(newNote);
  }

  Future<void> editNote(int index, String title, String body, DateTime time) async {
    Note updatedNote = Note(title: title, body: body, time: time);
    _noteBox.putAt(index, updatedNote);
    // final specifiedNote = _noteBox.getAt(index);
    // task.isDone = isDone;
    // await task.save();
  }

  Future<void> deleteTask(int index) async {
    await _noteBox.deleteAt(index);
  }

  List<Note> getAllTasks() {
    return _noteBox.values.toList();
  }

  List<Note> searchNotes(String query) {
    final allNotes = _noteBox.values.toList();

    // Use the 'where' method to filter notes that contain the query in the title or body
    final filteredNotes = allNotes.where((note) {
      final titleMatch = note.title.toLowerCase().contains(query.toLowerCase());
      final bodyMatch = note.body.toLowerCase().contains(query.toLowerCase());
      return titleMatch || bodyMatch;
    }).toList();

    return filteredNotes;
  }

}

final noteProvider = Provider<NoteRepository>((ref) {
  final noteBox = Hive.box<Note>("noteBox");
  return NoteRepository(noteBox);
});