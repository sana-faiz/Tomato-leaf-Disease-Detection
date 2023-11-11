import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plant/screens/home_screen.dart';
import 'package:plant/screens/MessagesScreen.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';


class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter
  _dialogFlowtter; // late Initialization of the dialogflowtter

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];
  // aik list jismay Map aye yani {:} aur isme first string ho second kuch bhi hoskta hai so dynamic lelia

  @override
  void initState() {
    // initializing the dialogflowtter
    DialogFlowtter.fromFile().then((instance) => _dialogFlowtter = instance);
    // ager file name dialog_flow_auth ki bjaye kuch aur ho tou fromAssets se access hoga
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ChatBot"),
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back_ios),
            //replace with our own icon data.
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // <-- SEE HERE
          ),
          actions: [
            IconButton(onPressed: () {},
            icon:  Icon(Icons.language_sharp))],
          //centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: MessagesScreen(messages: messages),
            ),
            Container(
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 14,
                ),
                child: Row(children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.green,
                    onPressed: () {
                      sendMessage(_controller.text);
                      _controller.clear();
                    },
                  )
                ]),
              ),
            ),
          ],
        ),
      ),

    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        // print("men msg apka add krne lga hun vroo");
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      // print("abhi tk code chal rha hai");
      DetectIntentResponse response = await _dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));

      // print(response.message.toString() + "Yeh response msg hai");

      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _dialogFlowtter.dispose();
    super.dispose();
  }
}

