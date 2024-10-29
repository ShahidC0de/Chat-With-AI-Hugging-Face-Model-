import 'dart:async';
import 'dart:io';

import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/chatting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? selectedImage;
  String displayText = '';
  String fullMessageTextToDisplay = '';
  Timer? _typingTimer;
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {}); // Update for showing/hiding the icon based on input
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _typingTimer?.cancel(); // Clean up the timer if it's running
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  void _startTypingAnimation(String message) {
    // Cancel any existing typing animation
    _typingTimer?.cancel();
    displayText = ""; // Reset display text
    fullMessageTextToDisplay = message; // Set the new message to display
    int index = 0;

    _typingTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (index < fullMessageTextToDisplay.length) {
        setState(() {
          displayText += fullMessageTextToDisplay[index];
          index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppStyles.cBlack,
      bottomSheet: Container(
        width: width,
        height: height * 0.08,
        padding: const EdgeInsets.all(10),
        color: AppStyles.cBlack,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: height * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black26,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _controller,
                  textAlign: TextAlign.start,
                  style: AppStyles.cSemiBold.copyWith(
                    color: AppStyles.cWhite,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: _controller.text.isEmpty
                        ? Icon(Icons.mic, color: AppStyles.cWhite)
                        : GestureDetector(
                            onTap: () {
                              final prompt = _controller.text.trim();
                              if (prompt.isNotEmpty) {
                                _controller.clear();
                                context.read<ChattingBloc>().add(
                                      GenerateRespnseClass(prompt: prompt),
                                    );
                              }
                            },
                            child: Icon(Icons.send, color: AppStyles.cWhite),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
              onTap: pickImage,
              child: Icon(
                Icons.photo,
                color: AppStyles.cWhite,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppStyles.cBlack,
        leading: Icon(Icons.menu, color: AppStyles.cWhite),
        title: Text(
          'ChatGPT 3.5',
          style: AppStyles.cSemiBold.copyWith(color: AppStyles.cWhite),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Sign up',
              style: AppStyles.cBold.copyWith(color: AppStyles.cBlack),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: BlocConsumer<ChattingBloc, ChattingState>(
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        displayText,
                        style: AppStyles.cSemiBold.copyWith(
                          color: AppStyles.cWhite,
                        ),
                      ),
                    );
                  } else if (state is ChatFailure) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return const SizedBox();
                },
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    _startTypingAnimation(state.response);
                  } else if (state is ChatFailure) {
                    debugPrint(state.message);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
