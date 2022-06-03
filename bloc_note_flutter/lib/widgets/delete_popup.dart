import 'package:flutter/material.dart';
import '../helper/note_provider.dart';
import '../models/note.dart';
import 'package:provider/provider.dart';

class DeletePopUp extends StatelessWidget {
  const DeletePopUp({
    Key? key,
    required this.selectedNote,
  }) : super(key: key);

  final Note selectedNote;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: Text('Supprimer ?'),
      content: Text('Tu es sur de vouloir supprimer la note ?'),
      actions: [
        FlatButton(
          child: Text('Oui'),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        TextButton(
          child: Text('Non'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
