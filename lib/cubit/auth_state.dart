abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLogin extends AuthState {
  final String message;
  final bool status;

  AuthLogin({required this.message, required this.status});
}

class AuthRegister extends AuthState {
  final String message;
  final bool status;

  AuthRegister({required this.message, required this.status});
}
