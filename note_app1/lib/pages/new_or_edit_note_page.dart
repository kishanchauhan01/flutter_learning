import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app1/core/constants.dart';
import 'package:note_app1/data/new_note_controller.dart';
import 'package:note_app1/widget/dialog_card.dart';
import 'package:note_app1/widget/new_tag_dialog.dart';
import 'package:note_app1/widget/note_icon_button.dart';
import 'package:note_app1/widget/note_icon_button_outlined.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app1/widget/note_tag.dart';
import 'package:note_app1/widget/note_toolbar.dart';
import 'package:provider/provider.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  late final NewNoteController newNoteController;
  late final QuillController quillController;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    newNoteController = context.read<NewNoteController>();

    quillController = QuillController.basic()
      ..addListener(() {
        newNoteController.content = quillController.document;
      });

    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //call this when the widget tree is available or this page is build then call this
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
    });
  }

  @override
  void dispose() {
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
            icon: FontAwesomeIcons.chevronLeft,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(widget.isNewNote ? "New Note" : "Edit Note"),
        actions: [
          Selector<NewNoteController, bool>(
            selector: (context, newNoteController) =>
                newNoteController.readOnly,
            builder: (context, readOnly, child) => NoteIconButtonOutlined(
              icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
              onPressed: () {
                newNoteController.readOnly = !readOnly;

                if (newNoteController.readOnly) {
                  FocusScope.of(context).unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            ),
          ),
          Selector<NewNoteController, bool>(
            selector: (_, newNoteController) => newNoteController.canSaveNote,
            builder: (_, canSaveNote, _) => NoteIconButtonOutlined(
              icon: FontAwesomeIcons.check,
              onPressed: canSaveNote ? () {
                newNoteController.saveNote(context);
                Navigator.pop(context);
              } : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Title here",
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
              ),
              onChanged: (newValue) {
                newNoteController.title = newValue;
              },
            ),

            if (!widget.isNewNote) ...[
              const Row(
                //last modified
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Last Modified",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
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
                            builder: (context) => Center(
                              child: DialogCard(child: NewTagDialog()),
                            ),
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray500, thickness: 2),
            ),

            Expanded(
              child: Selector<NewNoteController, bool>(
                selector: (_, controller) => controller.readOnly,
                builder: (_, readOnly, __) => Column(
                  children: [
                    Expanded(
                      child: QuillEditor.basic(
                        controller: quillController,
                        config: const QuillEditorConfig(
                          placeholder: "Note here...",
                          expands: true,
                        ),
                        focusNode: focusNode,
                      ),
                    ),
                    if (!readOnly)
                      NoteToolBar(quillController: quillController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
