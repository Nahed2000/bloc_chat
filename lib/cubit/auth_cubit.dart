import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebase/fb_auth.dart';
import '../model/fb_response.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    FbResponse fbResponse =
        await FbAuth().login(password: password, email: email);
    emit(AuthLogin(message: fbResponse.message, status: fbResponse.status));
  }

  Future<void> register(
      {required String email, required String password}) async {
    emit(AuthLoading());
    FbResponse fbResponse =
        await FbAuth().createAccount(email: email, password: password);
    emit(AuthRegister(message: fbResponse.message, status: fbResponse.status));
  }
}
