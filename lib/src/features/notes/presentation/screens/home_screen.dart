import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notepad/src/features/notes/domain/note_model.dart';
import 'package:notepad/src/features/notes/presentation/screens/add_screen.dart';
import 'package:notepad/src/features/notes/presentation/screens/edit_screen.dart';
import 'package:notepad/src/features/notes/presentation/screens/search_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SearchScreen(noteBox: Hive.box('noteBox'),);
            },)),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ValueListenableBuilder(
            valueListenable: Hive.box<Note>('noteBox').listenable(),
            builder: (context, box, _) {
              if (box.values.isEmpty) {
                return const Center(child: Text("No Notes"));
              } else {
                return ListView.separated(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    var currentNote = box.getAt(index);
      
                    return InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return EditScreen(index: index, note: currentNote);
                        },
                      )),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentNote!.title,
                                style: const TextStyle(
                                    fontSize: 15.5, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(currentNote.body),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('d MMM yyyy HH:mm a')
                                        .format(currentNote.time),
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w300),
                                  ),
                                  IconButton(onPressed: (){
                                    box.deleteAt(index);
                                  }, icon: const Icon(Icons.delete, color: Colors.red,))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(height: 12);
                  },
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const AddScreen();
            },
          ));
        },
      ),
    );
  }
}
