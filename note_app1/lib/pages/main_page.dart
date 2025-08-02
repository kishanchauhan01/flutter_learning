import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app1/core/constants.dart';
import 'package:note_app1/pages/new_or_edit_note_page.dart';
import 'package:note_app1/widget/note_fab.dart';
import 'package:note_app1/widget/note_grid.dart';
import 'package:note_app1/widget/note_icon_button.dart';
import 'package:note_app1/widget/note_icon_button_outlined.dart';
import 'package:note_app1/widget/note_list.dart';
import 'package:note_app1/widget/search_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> dropDownOptions = ['Date modified', 'Date created'];
  late String dropDownValue = dropDownOptions.first;

  bool isDescending = false;
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double spacing = screenWidth * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: Text("Awesome Notes 📒"),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () {},
          ),
        ],
      ),

      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewOrEditNotePage(isNewNote: true,);
              },
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            //Search bar
            SearchField(),

            //Filter row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  NoteIconButton(
                    icon: isDescending
                        ? FontAwesomeIcons.arrowDown
                        : FontAwesomeIcons.arrowUp,
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                    size: 18,
                  ),

                  SizedBox(width: 16.0),

                  DropdownButton(
                    value: dropDownValue,
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FaIcon(
                        FontAwesomeIcons.arrowDownWideShort,
                        size: 18,
                        color: gray700,
                      ),
                    ),
                    underline: SizedBox.shrink(),
                    borderRadius: BorderRadius.circular(16.0),
                    isDense: true,
                    items: dropDownOptions
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Text(e),
                                if (e == dropDownValue) ...[
                                  SizedBox(width: 8.0),
                                  Icon(Icons.check),
                                ],
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    selectedItemBuilder: (context) =>
                        dropDownOptions.map((e) => Text(e)).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    },
                  ),
                  Spacer(),

                  NoteIconButton(
                    icon: isGrid
                        ? FontAwesomeIcons.tableCellsLarge
                        : FontAwesomeIcons.bars,
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    size: 18,
                  ),
                ],
              ),
            ),

            //  Notes card
            Expanded(child: isGrid ? NotesGrid(spacing: spacing) : NotesList()),
          ],
        ),
      ),
    );
  }
}
