import 'package:flutter/material.dart';
import '../model/note.dart';
import '../note_db/note_db.dart';

class DeleteNote extends StatefulWidget {
  final Note? note;
  const DeleteNote({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<DeleteNote> createState() => _DeleteNoteState();
}

class _DeleteNoteState extends State<DeleteNote> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Eliminar Nota'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              '¿Estás seguro de que deseas eliminar esta nota?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.red,
              ),
              child: Text('Eliminar Nota'),
              onPressed: () {
                deleteNote();
              },
            ),
          ],
        ),
      ),
    );
  }
  void deleteNote() async {
    if (widget.note != null) {
      await NotesDatabase.instance.delete(widget.note!.id!);
    }
    Navigator.of(context).pop();
  }
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }
  Future refreshNote() async {
    setState(() => isLoading = true);
    this.note = await NotesDatabase.instance.readNote(widget.note as int);
    setState(() => isLoading = false);
  }

}
