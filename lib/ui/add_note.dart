import 'package:flutter/material.dart';

import '../model/note.dart';
import '../note_db/note_db.dart';
import '../widget/nota_form_widget.dart';

class AddNote extends StatefulWidget {
  final Note? note;

  const AddNote({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _fromKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: impleent build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Create Note'),
      ),
      body: ListView(
        children: [
          Form(
              child: NoteFormWidget(
                isImportant: isImportant,
                number: number,
                title: title,
                description: description,
                onChangedImportant: (isImportant) {
                  setState(() {
                    this.isImportant = isImportant;
                  });
                },
                onChangedNumber: (number) {
                  setState(() {
                    this.number = number;
                  });
                },
                onChangedTitle: (title) {
                  setState(() {
                    this.title = title;
                  });
                },
                onChangedDescription: (description) {
                  setState(() {
                    this.description = description;
                  });
                },
              )),
          buildButton()
        ],
      ),
    );
  }

  Widget buildButton() {
    final isFormValidate = title.isNotEmpty && description.isNotEmpty;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: isFormValidate ? null : Colors.grey),
          child: Text('Guardar'),
          onPressed: isFormValidate ? addOneNota : null),
    );
  }

  void addOneNota() async {
    await addNotes();
    Navigator.of(context).pop();
    final isValid = _fromKey.currentState!.validate();
    if (isValid) {
      final isUpdate = widget.note != null;
      if (!isUpdate) {
        await addNotes();
      } else {
        await updateNote();
      }
    }
  }

  Future addNotes() async {
    final note = Note(
        title: title,
        isImportant: true,
        number: number,
        description: description,
        createdTime: DateTime.now());
    await NotesDatabase.instance.create(note);
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      isImportant: true,
      number: number,
      description: description,
    );
    await NotesDatabase.instance.update(note);
  }
}
