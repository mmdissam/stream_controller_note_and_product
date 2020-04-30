import 'dart:async';

import 'package:flutter_streams_products/contracts/disposable.dart';
import 'package:flutter_streams_products/model/note.dart';

class NoteBloc implements Disposable {
  List<Note> notes;

  final StreamController<List<Note>> _notesController =
      StreamController<List<Note>>();

  Stream<List<Note>> get noteStream => _notesController.stream;

  StreamSink<List<Note>> get noteSink => _notesController.sink;

  final StreamController<Note> _noteController = StreamController<Note>();

  StreamSink<Note> get addNewNote => _noteController.sink;

  NoteBloc() {
    notes = [];
    _notesController.add(notes);
    _noteController.stream.listen(_addNote);
  }

  @override
  void dispose() {
    _notesController.close();
    _noteController.close();
  }

  void _addNote(Note note) {
    notes.add(note);
    noteSink.add(notes);
  }
}
