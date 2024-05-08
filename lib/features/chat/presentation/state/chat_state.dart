abstract class ChatState {
  const ChatState();
}

class ChatStateInitial extends ChatState {}

class ChatStateLoading extends ChatState {}

class ChatStateSuccess extends ChatState {}

class ChatStateError extends ChatState {
  final String message;

  ChatStateError(this.message);
}
