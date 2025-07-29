import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app1/constants.dart';

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
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.user),
            style: IconButton.styleFrom(
              backgroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: black),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: black, offset: Offset(4, 4))],
        ),
        child: FloatingActionButton.large(
          onPressed: null,
          backgroundColor: primary,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
            side: BorderSide(color: black),
          ),
          child: FaIcon(FontAwesomeIcons.plus),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            //Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search notes...",
                hintStyle: TextStyle(fontSize: 12),
                prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 18),
                fillColor: black,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                prefixIconConstraints: BoxConstraints(
                  minWidth: 42,
                  minHeight: 42,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: primary),
                ),
              ),
            ),

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

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 15,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return NoteCard(isInGrid: false);
      },
      separatorBuilder: (context, index) => SizedBox(height: 18),
    );
  }
}

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.spacing});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      clipBehavior: Clip.none,
      itemCount: 15,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 15,
        childAspectRatio: 3 / 3,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(isInGrid: true);
      },
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({required this.isInGrid, super.key});

  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(
          0xFF1C1C1E,
        ), // Dark card-like background (not transparent)
        border: Border.all(
          color: const Color(0xFF2C2C2E), // Slight gray for subtle border
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.25), // Soft glow from primary
            offset: const Offset(2, 2),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This is going to be title",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color.fromARGB(255, 160, 160, 160),
            ),
          ),
          SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                1,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: const Color.fromARGB(186, 195, 158, 24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  margin: EdgeInsets.only(right: 8.0),
                  child: Text(
                    "First chip",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          if (isInGrid)
            Expanded(
              child: Text(
                "Some content",
                style: TextStyle(
                  color: const Color.fromARGB(255, 160, 160, 160),
                ),
              ),
            )
          else
            Text(
              "Some content",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: const Color.fromARGB(255, 160, 160, 160)),
            ),

          Row(
            children: [
              Text(
                "02 Nov, 2023",
                style: TextStyle(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 160, 160, 160),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              FaIcon(
                FontAwesomeIcons.trash,
                color: const Color.fromARGB(255, 160, 160, 160),
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
