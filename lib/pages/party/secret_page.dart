import 'package:drug_management/database/models/note/note.dart';
import 'package:drug_management/services/notes_service.dart';
import 'package:flutter/material.dart';

class SecretPage extends StatefulWidget {
  const SecretPage({super.key});

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Column(children: [
        TextField(controller: _controller),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 0, 149)),
            onPressed: () {
              var notesService = NotesService();
              notesService.addNote(_controller.text);
            },
            child: Text('note')),
        Journal()
      ]),
    );
  }
}

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  Future<List<Note>> loadData() async {
    return NotesService().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasData) {
            List<Widget> children = [];
            var notes = snapshot.data;
            if (notes != null) {
              for (var note in notes) {
                children.add(Text(note.body));
              }
            }

            return Center(child: Column(children: children));
          }

          return Center(
            child: Text("No notes"),
          );
        });
  }
}
