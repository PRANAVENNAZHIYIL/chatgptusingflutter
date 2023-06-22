import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'models/openaimodel/openaimodel.dart';

class GptHome extends StatefulWidget {
  const GptHome({super.key});

  @override
  State<GptHome> createState() => _GptHomeState();
}

class _GptHomeState extends State<GptHome> {
  String responseText = 'Hi How can i help you';
  late TextEditingController promptControllers;
  late Openaimodel _getOpenaimodel;
  @override
  void initState() {
    promptControllers = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    promptControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        title: const Text(
          "chatgpt using flutter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff343541),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Resultbuilder(responseText: responseText),
          Textformbuilder(
              btFun: sendfunction, promptController: promptControllers)
        ],
      )),
    );
  }

  sendfunction() async {
    setState(() => responseText = "Loading...");

    final response = await http.post(
        Uri.parse("https://api.openai.com/v1/completions"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apikey'
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": promptControllers.text,
          "max_tokens": 7,
          "temperature": 0,
          "top_p": 1,
        }));
    setState(() {
      log(_getOpenaimodel as String);
      // var data = jsonDecode(response.body);
      _getOpenaimodel =
          Openaimodel.fromJson(response.body as Map<String, dynamic>);
      responseText = _getOpenaimodel.choices![0].text!;
    });
  }
}

class Resultbuilder extends StatelessWidget {
  final String responseText;
  const Resultbuilder({super.key, required this.responseText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.35,
      color: const Color(0xff434654),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Text(
              responseText,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class Textformbuilder extends StatelessWidget {
  const Textformbuilder(
      {Key? key, required this.btFun, required this.promptController})
      : super(key: key);
  final TextEditingController promptController;
  final void Function()? btFun;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                  cursorColor: Colors.white,
                  controller: promptController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff444653),
                          ),
                          borderRadius: BorderRadius.circular(5.5)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff444653))),
                      filled: true,
                      fillColor: const Color(0xff444653),
                      hintText: "Ask me Anything....",
                      hintStyle: const TextStyle(color: Colors.grey))),
            ),
            Container(
              color: const Color(0xff19bc99),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () => btFun!(),
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
