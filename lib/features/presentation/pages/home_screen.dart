import 'dart:async';

import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:chatgpt/features/presentation/widgets/chatgpt_logo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayText = '';
  String fullMessageTextToDisplay = '';
  Timer? _typingTimer;
  void _startTypingAnimation(String message) {
    fullMessageTextToDisplay = message;
    displayText = "";
    int index = 0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
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
            Container(
              height: height * 0.08,
              width: width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black26,
              ),
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusColor: AppStyles.cBlack,
                    suffixIcon: Icon(
                      Icons.mic,
                      color: AppStyles.cWhite,
                    )),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Icon(
              Icons.headphones,
              color: AppStyles.cWhite,
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppStyles.cBlack,
        leading: Icon(
          Icons.menu,
          color: AppStyles.cWhite,
        ),
        title: Text(
          'ChatGPT 3.5',
          style: AppStyles.cSemiBold.copyWith(
            color: AppStyles.cWhite,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Sign up',
              style: AppStyles.cBold.copyWith(
                color: AppStyles.cBlack,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomLogo(),
          )
        ],
      ),
    );
  }
}
