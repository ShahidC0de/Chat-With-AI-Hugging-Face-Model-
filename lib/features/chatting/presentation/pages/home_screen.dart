import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/chatting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewritertext/typewritertext.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String tempController = "";
  bool isLoading = false;

  bool checkIfThePromptIsLatest(String response) {
    if (response.isNotEmpty && _chatMessages.last['response'] == response) {
      return true;
    }
    return false;
  }

  final List<Map<String, dynamic>> _chatMessages = [
    {
      'prompt': 'hi i am shahid and i belong to Swat.',
      'response': 'hi i am ChatGPT, how can i help you?',
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
                  child: SingleChildScrollView(
                child: Column(
                    children: List.generate(_chatMessages.length, (index) {
                  final chatMessage = _chatMessages[index];
                  return _makeTextWidget(
                      prompt: chatMessage['prompt'] ?? "Prompt is empty",
                      response: chatMessage['response'] ?? "");
                })),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? CircularProgressIndicator(
                          color: AppStyles.cWhite,
                        )
                      : const SizedBox(
                          height: 10,
                          width: 10,
                        )
                ],
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
                    BlocListener<ChattingBloc, ChattingState>(
                      listener: (context, state) {
                        if (state is ChatLoading) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        if (state is ChatSuccess) {
                          setState(() {
                            _chatMessages.add({
                              'prompt': tempController,
                              'response': state.response,
                            });
                            isLoading = false;
                          });
                        }
                      },
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              tempController = controller.text;
                              if (controller.text.isNotEmpty) {
                                context.read<ChattingBloc>().add(
                                    GenerateRespnseClass(
                                        prompt: controller.text));
                              }
                            });
                          },
                          icon: Icon(
                            isLoading ? Icons.waving_hand : Icons.send,
                            color: AppStyles.cWhite,
                          )),
                    ),
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
                child: Text(
                  prompt,
                  style: AppStyles.cBold.copyWith(color: AppStyles.cWhite),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: AppStyles.cGrey.withOpacity(0.3),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: checkIfThePromptIsLatest(response)
                          ? TypeWriter.text(
                              response,
                              duration: const Duration(
                                milliseconds: 100,
                              ),
                              style: AppStyles.cSemiBold
                                  .copyWith(color: AppStyles.cWhite),
                            )
                          : Text(
                              response,
                              style: AppStyles.cSemiBold
                                  .copyWith(color: AppStyles.cWhite),
                            )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
