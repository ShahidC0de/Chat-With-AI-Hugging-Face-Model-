import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _chatMessages = [
    {
      'prompt':
          'hi i am shahid and i belong to Swat, Pakistan,hi i am shahid and i belong to Swat, Pakistan,hi i am shahid and i belong to Swat, Pakistan',
      'response':
          'hi i am chatGPT,i i am shahid and i belong to Swat,i i am shahid and i belong to Swat,i i am shahid and i belong to Swat,i i am shahid and i belong to Swat',
    },
    {
      'prompt': 'hi',
      'response': 'hi i am chatGPT',
    },
    {
      'prompt': 'hi',
      'response': 'hi i am chatGPT',
    },
    {
      'prompt': 'hi',
      'response': 'hi i am chatGPT',
    },
    {
      'prompt': 'hi',
      'response': 'hi i am chatGPT',
    },
    {
      'prompt': 'hi',
      'response': 'hi i am chatGPT',
    },
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppStyles.cBlack,
          appBar: AppBar(
            backgroundColor: AppStyles.cGrey.withOpacity(0.3),
            title: Text(
              "ChatGPT",
              style: AppStyles.cSemiBold.copyWith(
                color: AppStyles.cWhite,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _chatMessages.length,
                    itemBuilder: (context, index) {
                      final chatMessage = _chatMessages[index];
                      return _makeTextWidget(
                        prompt: chatMessage['prompt'],
                        response: chatMessage['response'],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          fillColor: AppStyles.cGrey.withOpacity(0.3),
                          filled: true,
                          hintText: "How can i help you?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _chatMessages.add({
                              'prompt': controller.text,
                              'response': controller.text,
                            });
                          });
                        },
                        icon: Icon(
                          Icons.send,
                          color: AppStyles.cWhite,
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget _makeTextWidget({
    required String prompt,
    required String response,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: AppStyles.cWhite,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TypeWriter.text(
                  prompt,
                  duration: const Duration(milliseconds: 100),
                  style: AppStyles.cBold.copyWith(color: AppStyles.cWhite),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: AppStyles.cGrey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TypeWriter.text(
                      response,
                      duration: const Duration(
                        milliseconds: 100,
                      ),
                      style:
                          AppStyles.cSemiBold.copyWith(color: AppStyles.cWhite),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
