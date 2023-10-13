import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  //ValueChanged  informa que un valor ha cambiado.
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }


  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: title,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Escriba un Titulo...',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'El título no puede estar vacío.' : null,
    onChanged: onChangedTitle,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: TextStyle(color: Colors.black, fontSize: 18),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Escriba su Nota...',
      hintStyle: TextStyle(color: Colors.black),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'La descripción no puede estar vacía.'
        : null,
    onChanged: onChangedDescription,
  );
}