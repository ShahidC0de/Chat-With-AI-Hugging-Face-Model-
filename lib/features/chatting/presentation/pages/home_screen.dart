import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:chatgpt/features/chatting/domain/entities/chat_session.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/chatting_bloc.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/savingsession_bloc.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/session_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String id = '';
  String tempController = "";
  bool isLoading = false;
  List<Map<String, dynamic>> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    fetchSessions();
    // Fetching sessions on initialization.
  }

  void fetchSessions() {
    context.read<SessionBloc>().add(GettingSessionsEvent());
  }

  bool checkIfThePromptIsLatest(String response) {
    if (response.isNotEmpty && _chatMessages.isNotEmpty) {
      return _chatMessages.last['response'] == response;
    }
    return false;
  }

  // Save session whenever a new message is added
  void saveSession() {
    if (id.isNotEmpty) {
      ChatSession session = ChatSession(
        id: id,
        messages: List.from(_chatMessages),
      );
      context
          .read<SavingsessionBloc>()
          .add(SaveUserSessionEvent(session: session));
    }

    fetchSessions();
  }

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
            style: AppStyles.cSemiBold.copyWith(color: AppStyles.cWhite),
          ),
        ),
        drawer: Drawer(
          backgroundColor: AppStyles.cBlack,
          child: BlocBuilder<SessionBloc, SessionBlocState>(
            builder: (context, state) {
              if (state is GettingSessionsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is GettingSessionsFailure) {
                return Text(state.message);
              }
              if (state is GettingSessionsSuccess) {
                if (state.sessions.isEmpty) {
                  return const SizedBox();
                } else {
                  return ListView(
                    children: [
                      DrawerHeader(
                        child: Text(
                          "History",
                          style: AppStyles.cSemiBold.copyWith(
                            color: AppStyles.cWhite,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _chatMessages.clear();
                              id = '';
                            });
                          },
                          child: ListTile(
                            tileColor: AppStyles.cGrey.withOpacity(0.3),
                            title: Text(
                              'New Chat',
                              style: AppStyles.cSemiBold.copyWith(
                                color: AppStyles.cWhite,
                              ),
                            ),
                            leading: const Icon(Icons.chat),
                          ),
                        ),
                      ),
                      ...state.sessions.map((session) {
                        String firstPrompt = session.messages.isNotEmpty
                            ? session.messages.first['prompt'] ?? "No Prompt"
                            : "No Messages";

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              _chatMessages = List.from(session.messages);
                              id = session.id;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              leading: const Icon(Icons.chat_bubble),
                              tileColor: AppStyles.cGrey.withOpacity(0.3),
                              title: Text(
                                firstPrompt,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.cSemiBold
                                    .copyWith(color: AppStyles.cWhite),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
        body: BlocListener<ChattingBloc, ChattingState>(
          listener: (context, state) {
            if (state is ChatLoading) {
              setState(() {
                isLoading = true;
              });
            }
            if (state is ChatSuccess) {
              setState(() {
                if (id.isEmpty) {
                  id = const Uuid().v4().toString();
                }
                _chatMessages.add({
                  'prompt': tempController,
                  'response': state.response,
                });
                isLoading = false;
                // Save session after new chat response
                saveSession();
              });
            }
          },
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      _chatMessages.length,
                      (index) {
                        final chatMessage = _chatMessages[index];
                        return _makeTextWidget(
                          prompt: chatMessage['prompt'] ?? "Prompt is empty",
                          response: chatMessage['response'] ?? "",
                        );
                      },
                    ),
                  ),
                ),
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
                          hintText: "How can I help you?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    isLoading
                        ? CircularProgressIndicator(color: AppStyles.cWhite)
                        : IconButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                if (_chatMessages.isEmpty && id.isEmpty) {
                                  id = const Uuid().v4().toString();
                                }

                                tempController = controller.text;
                                context.read<ChattingBloc>().add(
                                    GenerateRespnseClass(
                                        prompt: controller.text));
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: AppStyles.cWhite,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
              Icon(Icons.person, color: AppStyles.cWhite),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  prompt,
                  style: AppStyles.cBold.copyWith(color: AppStyles.cWhite),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
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
                            duration: const Duration(milliseconds: 100),
                            style: AppStyles.cSemiBold
                                .copyWith(color: AppStyles.cWhite),
                          )
                        : Text(
                            response,
                            style: AppStyles.cSemiBold
                                .copyWith(color: AppStyles.cWhite),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
