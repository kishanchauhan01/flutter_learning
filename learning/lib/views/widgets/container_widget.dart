import "package:flutter/material.dart";
import "package:learning/data/constants.dart";

class ContainerWidget extends StatefulWidget {
  final String title;
  final String description;
  const ContainerWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: KTextStyle.titleTealText), // title
              Text(
                widget.description,
                style: KTextStyle.descriptionText,
              ), //description
            ],
          ),
        ),
      ),
    );
  }
}
