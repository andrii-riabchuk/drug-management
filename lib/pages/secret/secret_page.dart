import 'package:drug_management/database/models/note/note.dart';
import 'package:drug_management/services/notes_service.dart';
import 'package:flutter/material.dart';

class SecretPage extends StatefulWidget {
  const SecretPage({super.key});

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  final notesService = NotesService();
  late TextEditingController _controller;

  Future loadData() async {
    noteList.addAll(await NotesService().getNotes());
  }

  late Future _data = loadData();

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

  List<Note> noteList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              appBar: AppBar(title: Text("Notes")),
              body: Column(children: [
                TextField(controller: _controller),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 0, 149)),
                    onPressed: () {
                      if (_controller.text.isEmpty) return;
                      notesService
                          .addNote(_controller.text)
                          .then((note) => setState(() {
                                noteList.add(note);
                              }));
                      _controller.text = "";
                    },
                    child: Text('note')),
                Journal(noteList)
              ]));
        });
  }
}

class Journal extends StatelessWidget {
  const Journal(this.noteList, {super.key});
  final List<Note> noteList;

  @override
  Widget build(BuildContext context) {
    if (noteList.isEmpty) {
      return Center(
        child: Text("No notes"),
      );
    }
    var widgets = noteList.map((x) => Text(x.body)).toList().reversed.toList();
    return Center(child: Column(children: widgets));
  }
}
