import 'package:chatgpt/core/init_dependencies.dart';
import 'package:chatgpt/core/splash_screen.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/chatting_bloc.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/savingsession_bloc.dart';
import 'package:chatgpt/features/chatting/presentation/bloc/session_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<ChattingBloc>(),
    ),
    BlocProvider(create: (_) => serviceLocator<SessionBloc>()),
    BlocProvider(create: (_) => serviceLocator<SavingsessionBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
