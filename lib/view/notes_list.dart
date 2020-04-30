import 'package:flutter/material.dart';
import 'package:flutter_streams_products/blocs/notes_bloc.dart';
import 'package:flutter_streams_products/model/note.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NoteBloc noteBloc = NoteBloc();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    noteBloc.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: noteBloc.noteStream,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error!');
              } else {
                List<Note> notes = snapshot.data;
                return Column(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, position) {
                            return ListTile(
                              title: Text(notes[position].content.toString()),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        controller: _textEditingController,
                      ),
                    ),
                    RaisedButton(
                        color: Colors.white30,
                        child: Text('Add New'),
                        onPressed: () {
                          String content = _textEditingController.text;
                          Note note = Note(content);
                          noteBloc.addNewNote.add(note);
                        }),
                    SizedBox(
                      height: 16,
                    )
                  ],
                );
              }
              break;
          }
        });
  }
}
