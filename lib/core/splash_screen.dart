import 'dart:async';

import 'package:chatgpt/core/constants/app_colors.dart';
import 'package:chatgpt/welcome.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final List<Color> colorsList = [
  AppStyles.cPrimaryBlue,
  AppStyles.cGreen,
  AppStyles.cWhite,
  AppStyles.cSenderBubbleCar,
  AppStyles.cGrey,
];

class _SplashScreenState extends State<SplashScreen> {
  Color _dotColor = AppStyles.cWhite;
  Timer? _timer;
  void _startColorAnimation() {
    int index = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dotColor = colorsList[index];
        index = (index + 1) % colorsList.length;
      });
    });
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Welcome()));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _startColorAnimation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _dotColor,
          ),
        ),
      ),
    );
  }
}
