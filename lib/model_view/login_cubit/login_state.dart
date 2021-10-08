class LoginState {}

class SocialLoginInitState extends LoginState {}

class SocialLoginLoadingState extends LoginState {}

class SocialLoginSucceedState extends LoginState {
  final String uId;

  SocialLoginSucceedState(this.uId);
}

class SocialLoginErrorState extends LoginState {
  final String error;

  SocialLoginErrorState(this.error);
}

class SocialChangeVisibiltyState extends LoginState {}

class SocialCreateUserInFirestoreState extends LoginState {
  final String uId;

  SocialCreateUserInFirestoreState(this.uId);
}

class SocialErrorDuringCreateUserInFirestoreState extends LoginState {
  final String error;

  SocialErrorDuringCreateUserInFirestoreState(this.error);
}
