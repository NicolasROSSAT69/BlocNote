import 'package:flutter/material.dart';
import 'package:bloc_note_flutter/helper/database_helper.dart';
import '../models/note.dart';
import '../utils/constants.dart';

class NoteProvider with ChangeNotifier {
  List _items = [];

  List get items {
    return [..._items];
  }

  Future addOrUpdateNote(int id, String title, String content, String imagePath,
      EditMode editMode) async {
    final note = Note(id, title, content, imagePath);

    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }

    notifyListeners();

    DatabaseHelper.insert(
      {
        'id': note.id,
        'title': note.title,
        'content': note.content,
        'imagePath': note.imagePath,
      },
    );
  }

  Future getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();

    _items = notesList
        .map(
          (item) => Note(
              item['id'], item['title'], item['content'], item['imagePath']),
        )
        .toList();

    notifyListeners();
  }
}
