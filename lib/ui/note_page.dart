import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notas/ui/note_detail_page.dart';
import '../model/note.dart';
import '../note_db/note_db.dart';
import '../widget/nota_card_widget.dart';
import 'add_note.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.teal,
      title: Text(
        'Mis Notas',
        style: TextStyle(fontSize: 24),
      ),
    ),
    body: Center(
      child: isLoading
          ? CircularProgressIndicator()
          : notes.isEmpty
          ? Text(
        'No Hay Notas',
        style: TextStyle(color: Colors.white, fontSize: 24),
      )
          : buildNotes(),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddNote()),
        );

        refreshNotes();
      },
    ),

  );

  Widget buildNotes() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: notes.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final note = notes[index];

        return InkWell(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (index) => NoteDetailPage(noteId: note.id!),
              ),
            );
            refreshNotes();
          },
          child: NoteCardWidget(note: note, index: index),
        );
      },
    );
  }
}
