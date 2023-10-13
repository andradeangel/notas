import 'package:flutter/material.dart';
import 'package:notas/ui/note_page.dart';
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

  late List<Note> notes;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {

    if (widget.note != null) {
      isImportant = widget.note!.isImportant;
      number = widget.note!.number;
      title = widget.note!.title;
      description = widget.note!.description;
    } else {

      isImportant = false;
      number = 0;
      title = '';
      description = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.note != null ? 'Editar Nota' : 'Crear Nota'), // Cambia el título según si estás editando o creando.
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
          buildButton()
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
          primary: Colors.teal,
        ),
        child: Text(widget.note != null ? 'Editar' : 'Guardar'),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (widget.note != null) {
              updateNote();
            } else {
              addNotes();
            }
          }
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => NotesPage()),
          );
        },
      ),
    );
  }

  void addNotes() async {
    final note = Note(
      title: title,
      isImportant: isImportant,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );
    await NotesDatabase.instance.create(note);
  }

  void updateNote() async {
    final note = widget.note!.copy(
      title: title,
      isImportant: isImportant,
      number: number,
      description: description,
    );
    await NotesDatabase.instance.update(note);
  }
}
