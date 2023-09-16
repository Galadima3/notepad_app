import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:notepad/src/features/notes/domain/note_model.dart';
import 'package:notepad/src/features/notes/presentation/widgets/custom_message.dart';
import 'package:notepad/src/features/notes/presentation/widgets/note_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final Box<Note> noteBox;
  const SearchScreen({super.key, required this.noteBox});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final searchController = TextEditingController();
  List<Note> _filteredNotes = [];
  @override
  void initState() {
    super.initState();

    searchController.addListener(onSearchTextChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchTextChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredNotes = [];
      } else {
        _filteredNotes = widget.noteBox.values.where((note) {
          String title = note.title.toLowerCase();
          String body = note.body.toLowerCase();
          return title.contains(query) || body.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 350,
          height: 45,
          child: SearchBar(
              leading: const Icon(Icons.search),
              controller: searchController,
              onChanged: (value) {}),
        ),
      ),
      body: Column(
        children: [
          // Center(
          //   child: SizedBox(
          //     width: 330,
          //     height: 50,
          //     child: SearchBar(
          //         leading: const Icon(Icons.search),
          //         controller: searchController,
          //         onChanged: (value) {}),
          //   ),
          // ),
          _filteredNotes.isEmpty
              ? Center(
                  child: searchController.text.isEmpty
                      ? const CustomMessage(
                          message: 'Enter a search query',
                        )
                      : const CustomMessage(message: 'No matching notes'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: _filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = _filteredNotes[index];
                      return NoteTile(
                        note: note,
                        body: note.body,
                        time: note.time,
                        title: note.title,
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}

