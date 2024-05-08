abstract class HomeState {
  const HomeState();
}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {}

class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}
