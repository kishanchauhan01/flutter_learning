import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app1/core/constants.dart';
import 'package:note_app1/widget/note_fab.dart';
import 'package:note_app1/widget/note_grid.dart';
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

      floatingActionButton: NoteFab(onPressed: () {}),

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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDescending = !isDescending;
                      });
                    },
                    icon: FaIcon(
                      isDescending
                          ? FontAwesomeIcons.arrowDown
                          : FontAwesomeIcons.arrowUp,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconSize: 18,
                    color: gray700,
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
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                    icon: FaIcon(
                      isGrid
                          ? FontAwesomeIcons.tableCellsLarge
                          : FontAwesomeIcons.bars,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(),
                    style: IconButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    iconSize: 18,
                    color: gray700,
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

