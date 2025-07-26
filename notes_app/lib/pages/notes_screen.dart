import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController titleTxtCtrl = TextEditingController();
  TextEditingController descriptionTxtCtrl = TextEditingController();
  String selId = "";

  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //add
        TextField(
          controller: titleTxtCtrl,
          decoration: InputDecoration(
            hintText: "Enter Title",
            labelText: "Title",
          ),
        ),
        TextField(
          controller: descriptionTxtCtrl,
          decoration: InputDecoration(
            hintText: "Enter Description",
            labelText: "Description",
          ),
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            //add logic
            setState(() {
              //If state variables have some updates which is not available as output then this state is known as dirty state

              if (titleTxtCtrl.text.isNotEmpty &&
                  descriptionTxtCtrl.text.isNotEmpty) {
                if (selId != "") {
                  int index = notes.indexWhere(
                    (element) => element.id == selId,
                  );

                  if (index >= 0) {
                    notes[index] = Note(
                      title: titleTxtCtrl.text,
                      description: descriptionTxtCtrl.text,
                      id: selId,
                    );
                  }
                  // // we are not using below code to update because some time it is not reflected on UI
                  // notes[index].title = titleTxtCtrl.text
                } else {
                  notes.add(
                    Note(
                      title: titleTxtCtrl.text,
                      description: descriptionTxtCtrl.text,
                      id: DateTime.now().toIso8601String(),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Title and Description are required"),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              titleTxtCtrl.clear();
              descriptionTxtCtrl.clear();
            });
          },
          child: Text(selId == "" ? "Add" : "Update"),
        ),
        //display
        Expanded(
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].description),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      titleTxtCtrl.text = notes[index].title;
                      descriptionTxtCtrl.text = notes[index].description;
                      selId = notes[index].id;
                      setState(() {});
                    },
                    icon: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10.0),
                  IconButton(
                    onPressed: () {
                      notes.removeAt(index);
                      setState(() {});
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
