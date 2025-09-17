import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app1/core/constants.dart';
import 'package:note_app1/data/new_note_controller.dart';
import 'package:note_app1/widget/dialog_card.dart';
import 'package:note_app1/widget/new_tag_dialog.dart';
import 'package:note_app1/widget/note_icon_button.dart';
import 'package:note_app1/widget/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({super.key, required this.isNewNote});
  final bool isNewNote;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.isNewNote) ...[
          const Row(
            //last modified
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Last Modified",
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "07 December 2023, 03:35 PM",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Row(
            //created at
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  "Created",
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "06 December 2023, 03:35 PM",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
        Row(
          //tags
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    "Tags",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray500,
                    ),
                  ),
                  NoteIconButton(
                    icon: FontAwesomeIcons.circlePlus,
                    onPressed: () async {
                      final String? tag = await showDialog<String>(
                        context: context,
                        builder: (context) =>
                            Center(child: DialogCard(child: NewTagDialog())),
                      );

                      if (tag != null) {
                        newNoteController.addTags(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewNoteController, List<String>>(
                selector: (_, newNoteController) => newNoteController.tags,
                builder: (_, tags, _) => tags.isEmpty
                    ? Text(
                        "No tags added",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            tags.length,
                            (index) => NoteTag(
                              label: tags[index],
                              onColsed: () {
                                newNoteController.removeTag(index);
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
