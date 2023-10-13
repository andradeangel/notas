import 'package:flutter/material.dart';
import '../model/note.dart';
import '../note_db/note_db.dart';
import '../widget/nota_form_widget.dart';

class EditNote extends StatefulWidget {
  final Note? note;

  const EditNote({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _formKey = GlobalKey<FormState>();
  bool isImportant = false;
  int number = 0;
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      isImportant = widget.note!.isImportant;
      number = widget.note!.number;
      title = widget.note!.title;
      description = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Editar Nota'),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
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
            ),
          ),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: Colors.teal, // Usamos siempre el color teal para editar
        ),
        child: Text('Guardar'),
        onPressed: saveNote,
      ),
    );
  }

  void saveNote() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final updatedNote = widget.note!.copy(
      title: title,
      isImportant: isImportant,
      number: number,
      description: description,
    );
    await NotesDatabase.instance.update(updatedNote);

    Navigator.of(context).pop();
  }
}
