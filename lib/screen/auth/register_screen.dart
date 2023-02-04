import 'package:bloc_chat/cubit/auth_cubit.dart';
import 'package:bloc_chat/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubit/auth_state.dart';
import '../../widget/my_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helper {
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

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

  bool indicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Register Screen',
          style:
              TextStyle(color: Colors.blue[800], fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthLoading) {
            indicator = true;
          } else if (state is AuthRegister) {
            showSnackBar(context, message: state.message, error: !state.status);
            if (state.status) {
              Navigator.pop(context);
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
                    color: Colors.blue[800]!,
                    title: 'register',
                    onPressed: () async => _performRegister(),
                  ),
                  MyButton(
                    color: Colors.blue[800]!,
                    title: 'Do you have account? Sign in',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _performRegister() async {
    if (checkData()) {
      BlocProvider.of<AuthCubit>(context).register(
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
            'Required Data, Please Enter your information Password, Email and full Name ',
        error: true);
    return false;
  }
//
// Future<void> register() async {
//   setState(() {
//     indicator = true;
//   });
//   FbResponse fbResponse = await FbAuth().createAccount(
//       email: _emailController.text, password: _passwordController.text);
//   showSnackBar(context,
//       message: fbResponse.message, error: !fbResponse.status);
//   setState(() {
//     indicator = false;
//   });
//   if (fbResponse.status) {
//     Navigator.pop(context);
//   }
// }
}
