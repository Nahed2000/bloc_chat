import 'dart:async';

import 'package:bloc_chat/model/fb_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
typedef UsersStatusCallBack = void Function({required bool loggedIn});

class FbAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription checkUserStatus(UsersStatusCallBack usersStatusCallBack) {
    return firebaseAuth.authStateChanges().listen((User? user) {
      usersStatusCallBack(loggedIn: user != null);
    });
  }
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  Future<FbResponse> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        userCredential.user!.sendEmailVerification();
        return FbResponse(message: 'Create Account Successfully', status: true);
      }
    } on FirebaseAuthException catch (e) {
      return controllerError(firebaseAuthException: e);
    } catch (e) {
      //
    }
    return FbResponse(message: 'Something went wrong', status: false);
  }

  Future<FbResponse> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        String message = userCredential.user!.emailVerified
            ? 'Login Successfully '
            : ' You must verify email';
        return FbResponse(
            message: message, status: userCredential.user!.emailVerified);
      }
    } on FirebaseAuthException catch (e) {
      return controllerError(firebaseAuthException: e);
    }
    return FbResponse(message: 'Something went wrong ', status: false);
  }

  FbResponse controllerError(
      {required FirebaseAuthException firebaseAuthException}) {
    return FbResponse(
      message: firebaseAuthException.message ?? 'error went wrong',
      status: false,
    );
  }

  bool get loggedIn => firebaseAuth.currentUser!=null;

}
