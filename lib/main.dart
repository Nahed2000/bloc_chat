import 'package:bloc_chat/cubit/auth_cubit.dart';
import 'package:bloc_chat/screen/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screen/auth/login_screen.dart';
import 'screen/auth/register_screen.dart';
import 'screen/lunch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/lunch_screen',
        routes: {
          '/lunch_screen': (context) => const LunchScreen(),
          '/login_screen': (context) => const LoginScreen(),
          '/register_screen': (context) => const RegisterScreen(),
          '/chat_screen': (context) => const ChatScreen(),
        },
      ),
    );
  }
}
