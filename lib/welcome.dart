import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:chatgpt/features/chatting/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.cBlack,
        body: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to \nChatGPT',
                style: AppStyles.cLargeBold,
              ),
              const SizedBox(height: 5),
              Text(
                'This official app is free, syncs your history across devices, and brings you the latest model improvements from OpenAI.',
                style: AppStyles.cSemiBold.copyWith(
                  color: AppStyles.cWhite,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 50),
              _buildRow(
                  Icons.search,
                  'ChatGPT can be inaccurate',
                  'ChatGPT may provide inaccurate \ninformation about people, places, or facts.',
                  null),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: AppStyles.cWhite,
              ),
              const SizedBox(
                height: 20,
              ),
              _buildRow(
                Icons.lock,
                "Dont't share sensitive info",
                'Chats may be reviewed and used to train \nour models. ',
                'Learn about your choices.',
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                height: height * 0.11,
                width: width * 0.9,
                decoration: BoxDecoration(
                    color: AppStyles.cBlack,
                    border: Border.all(
                      color: AppStyles.cWhite,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: RichText(
                  text: TextSpan(
                    text: 'By continuing you agree to our ',
                    style: AppStyles.cSemiBold.copyWith(
                      color: AppStyles.cWhite,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms ',
                        style: AppStyles.cSemiBold.copyWith(
                          color: AppStyles.cWhite,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationColor: AppStyles.cWhite,
                        ),
                      ),
                      TextSpan(
                        text: 'and have read our ',
                        style: AppStyles.cSemiBold.copyWith(
                          color: AppStyles.cWhite,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: AppStyles.cSemiBold.copyWith(
                          color: AppStyles.cWhite,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationColor: AppStyles.cWhite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width * 0.9,
                height: height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppStyles.cWhite,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ChatScreen()));
                    },
                    child: Text('Continue',
                        style: AppStyles.cBold.copyWith(
                          fontSize: 17,
                          color: AppStyles.cBlack,
                        ))),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    IconData icon,
    String titleText,
    String content,
    String? underlinedText,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppStyles.cWhite,
          size: 35,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
          children: [
            Text(
              titleText,
              style: AppStyles.cBold.copyWith(
                color: AppStyles.cWhite,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: content,
                style: AppStyles.cSemiBold
                    .copyWith(color: AppStyles.cWhite, fontSize: 15),
                children: [
                  TextSpan(
                      text: underlinedText,
                      style: AppStyles.cSemiBold.copyWith(
                        color: AppStyles.cWhite,
                        fontSize: 15,
                        decorationColor: AppStyles.cWhite,
                        decoration: TextDecoration.underline,
                      ))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
