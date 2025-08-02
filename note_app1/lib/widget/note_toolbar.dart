import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app1/core/constants.dart';

class NoteToolBar extends StatelessWidget {
  const NoteToolBar({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          color: primary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(color: primary, offset: Offset(4, 4))],
      ),
      child: QuillSimpleToolbar(
        controller: quillController,
        config: const QuillSimpleToolbarConfig(
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showInlineCode: false,
          showAlignmentButtons: false,
          showDirection: false,
          showDividers: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          buttonOptions: QuillSimpleToolbarButtonOptions(
            undoHistory: QuillToolbarHistoryButtonOptions(
              iconData: FontAwesomeIcons.arrowRotateLeft,
              iconSize: 16,
            ),
            redoHistory: QuillToolbarHistoryButtonOptions(
              iconData: FontAwesomeIcons.arrowRotateRight,
              iconSize: 16,
            ),
            bold: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.bold,
              iconSize: 16,
            ),
            italic: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.italic,
              iconSize: 16,
            ),
            underLine: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.underline,
              iconSize: 16,
            ),
            strikeThrough: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.strikethrough,
              iconSize: 16,
            ),
            color: QuillToolbarColorButtonOptions(
              iconData: FontAwesomeIcons.pallet,
              iconSize: 16,
            ),
            backgroundColor: QuillToolbarColorButtonOptions(
              iconData: FontAwesomeIcons.fillDrip,
              iconSize: 16,
            ),
            clearFormat: QuillToolbarClearFormatButtonOptions(
              iconData: FontAwesomeIcons.textSlash,
              iconSize: 16,
            ),
            listNumbers: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.listOl,
              iconSize: 16,
            ),
            listBullets: QuillToolbarToggleStyleButtonOptions(
              iconData: FontAwesomeIcons.listUl,
              iconSize: 16,
            ),
            search: QuillToolbarSearchButtonOptions(
              iconData: FontAwesomeIcons.magnifyingGlass,
              iconSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
