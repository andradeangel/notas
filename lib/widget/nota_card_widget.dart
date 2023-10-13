import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/note.dart';
import '../ui/edit_note.dart';


final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];
class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditNote()),
                        );

                        //refreshNotes();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Agrega la lógica para eliminar aquí
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              note.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../model/note.dart';
//
//
// final _lightColors = [
//   Colors.amber.shade300,
//   Colors.lightGreen.shade300,
//   Colors.lightBlue.shade300,
//   Colors.orange.shade300,
//   Colors.pinkAccent.shade100,
//   Colors.tealAccent.shade100
// ];
//
// class NoteCardWidget extends StatelessWidget {
//   NoteCardWidget({
//     Key? key,
//     required this.note,
//     required this.index,
//   }) : super(key: key);
//
//   final Note note;
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final color = _lightColors[index % _lightColors.length];
//     final time = DateFormat.yMMMd().format(note.createdTime);
//     final minHeight = getMinHeight(index);
//
//     return Card(
//       color: color,
//       child: Container(
//         constraints: BoxConstraints(minHeight: minHeight),
//         padding: EdgeInsets.all(8),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(time,
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//             SizedBox(height: 4),
//             Text(note.title,
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   double getMinHeight(int index) {
//     switch (index % 4) {
//       case 0:
//         return 100;
//       case 1:
//         return 150;
//       case 2:
//         return 150;
//       case 3:
//         return 100;
//       default:
//         return 100;
//     }
//   }
// }
