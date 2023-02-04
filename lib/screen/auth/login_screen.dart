import 'package:bloc_chat/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubit/auth_state.dart';
import '../../util/helper.dart';
import '../../widget/my_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  bool indicator = false;

  @override
  void initState() {
    // TODO: implement initState
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Sign in Screen',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.yellow[900],
              fontSize: 22),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          print('************');
          print(state);
          print('************');
          if (state is AuthLoading) {
            indicator = true;
          } else if (state is AuthLogin) {
            showSnackBar(context, message: state.message, error: !state.status);
            if (state.status) {
              Navigator.pushReplacementNamed(context, '/chat_screen');
            }
            indicator = false;
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: indicator,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 180,
                    child: Image.asset('images/logo.png'),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    color: Colors.yellow[900]!,
                    title: 'Sign in',
                    onPressed: () async => _performLogin(),
                  ),
                  MyButton(
                    color: Colors.yellow[900]!,
                    title: 'Don\'t have account? register Now ',
                    onPressed: () =>
                        Navigator.pushNamed(context, '/register_screen'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _performLogin() async {
    if (checkData()) {
      BlocProvider.of<AuthCubit>(context).login(
          email: _emailController.text, password: _passwordController.text);
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message:
            'Required Data, Please Enter your information Password and Email ',
        error: true);
    return false;
  }

// Future<void> login() async {
//   setState(() {
//     indicator = true;
//   });
//   // FbResponse fbResponse = await FbAuth().login(
//   //     password: _passwordController.text, email: _emailController.text);
//   // showSnackBar(context,
//   //     message: fbResponse.message, error: !fbResponse.status);
//   setState(() {
//     indicator = false;
//   });
//   if (fbResponse.status) {
//     Navigator.pushReplacementNamed(context, '/chat_screen');
//   }
// }
}
