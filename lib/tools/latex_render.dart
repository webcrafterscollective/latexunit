import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class LatexRender extends StatelessWidget {
  const LatexRender({super.key, 
    required this.text,
    required this.textStyle,
  });
   final String text;
   final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    List<Widget> parsedWidgets = _parseText(text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parsedWidgets,
    );
  }

  List<Widget> _parseText(String text) {
    List<Widget> widgets = [];
    List<Widget> rowWidgets = [];

    RegExp expMultiLatex = RegExp(r"\$\$(.*?)\$\$", multiLine: true);
    RegExp expLatex = RegExp(r"\\\((.*?)\\\)", multiLine: true);
    RegExp expImage = RegExp(r"\[\[(.*?)\]\]", multiLine: true);

    String textCopy = text;

    while (textCopy.isNotEmpty) {
      Match? matchMultiLatex = expMultiLatex.firstMatch(textCopy);
      Match? matchLatex = expLatex.firstMatch(textCopy);
      Match? matchImage = expImage.firstMatch(textCopy);

      // Handle multiline LaTeX
      if (matchMultiLatex != null &&
          (matchLatex == null || matchMultiLatex.start < matchLatex.start) &&
          (matchImage == null || matchMultiLatex.start < matchImage.start)) {
        if (matchMultiLatex.start > 0) {
          rowWidgets.add(Flexible(
            child: Text(
              textCopy.substring(0, matchMultiLatex.start),
              style: textStyle,
              softWrap: true,
            ),
          ));
        }

        if (rowWidgets.isNotEmpty) {
          widgets.add(Row(children: rowWidgets));
          rowWidgets = [];
        }

        widgets.add(Math.tex(
          matchMultiLatex.group(1)!,
          textStyle: textStyle,
        ));
        textCopy = textCopy.substring(matchMultiLatex.end);
      }
      // Handle inline LaTeX
      else if (matchLatex != null &&
          (matchImage == null || matchLatex.start < matchImage.start)) {
        if (matchLatex.start > 0) {
          rowWidgets.add(Flexible(
            child: Text(
              textCopy.substring(0, matchLatex.start),
              style: textStyle,
              softWrap: true,
            ),
          ));
        }

        rowWidgets.add(Math.tex(
          matchLatex.group(1)!,
          textStyle: textStyle,
        ));
        textCopy = textCopy.substring(matchLatex.end);
      }
      // Handle images
      else if (matchImage != null) {
        if (matchImage.start > 0) {
          rowWidgets.add(Flexible(
            child: Text(
              textCopy.substring(0, matchImage.start),
              style: textStyle,
              softWrap: true,
            ),
          ));
        }

        if (rowWidgets.isNotEmpty) {
          widgets.add(Row(children: rowWidgets));
          rowWidgets = [];
        }

        widgets.add(Flexible(child: Image.network(matchImage.group(1)!)));
        textCopy = textCopy.substring(matchImage.end);
      }
      // Add remaining text to the last row
      else {
        if (textCopy.isNotEmpty) {
          rowWidgets.add(Flexible(
            child: Text(
              textCopy,
              style: textStyle,
              softWrap: true,
            ),
          ));
        }
        break;
      }
    }

    if (rowWidgets.isNotEmpty) {
      widgets.add(Row(children: rowWidgets));
    }

    return widgets;
  }
}