import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:note_app1/core/constants.dart";



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
