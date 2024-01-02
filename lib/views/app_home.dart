import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latexunit/models/latex.dart';
import 'package:latexunit/tools/latex_render.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final TextEditingController inputEditingController = TextEditingController();

  var textToRender = 'Test Panel';

  void renderText(jsonTxt) {

    Map<String, dynamic> jsonMap = json.decode(jsonTxt);
    Latex latex = Latex.fromJson(jsonMap);

    setState(() {
      textToRender = latex.text;
    });
  }

  String jsonify(txt) {
    Latex latex = Latex(text: txt);
    Map<String, dynamic> latexJson = latex.toJson();
    return json.encode(latexJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Rendered Latex'),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(width: 1.0),
                ),
                child: SingleChildScrollView(
                  child: LatexRender(
                    text: textToRender,
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Multiline : \$\$...\$\$',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  
                  Text(
                    'Inline: \\(...\\)',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  TextField(
                    controller: inputEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    decoration: const InputDecoration(
                        labelText: 'Latex Input',
                        hintText: 'Enter Latex Code here',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        var jsonified = jsonify(inputEditingController.text);
                     
                        renderText(jsonified);
                      },
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
