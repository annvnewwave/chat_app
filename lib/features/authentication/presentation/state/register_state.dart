abstract class RegisterState {
  const RegisterState();
}

class RegisterStateInitial extends RegisterState {}

class RegisterStateLoading extends RegisterState {}

class RegisterStateSuccess extends RegisterState {}

class RegisterStateError extends RegisterState {
  final String message;

  RegisterStateError(this.message);
}