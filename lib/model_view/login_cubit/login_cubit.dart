import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:man_chatting/model/models/user_model.dart';
import 'login_state.dart';

class CubitLogIn extends Cubit<LoginState> {
  CubitLogIn() : super(SocialLoginInitState());

  static CubitLogIn get(context) => BlocProvider.of(context);

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    print("hello ");
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("user register  ");
      emit(SocialLoginSucceedState(value.user!.uid));
      createUserInFireStore(
          name: name, email: email, phone: phone, uId: value.user!.uid);
    }).catchError((e) {
      print("user error  ");
      emit(SocialLoginErrorState(e.toString()));
    });
  }

  void logIn({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    print("hello ");
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("user login");
      emit(SocialLoginSucceedState(value.user!.uid));
    }).catchError((e) {
      print("user error ");
      emit(SocialLoginErrorState(e.toString()));
    });
  }

  bool isVisible = true;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(SocialChangeVisibiltyState());
  }

  void createUserInFireStore(
      {required String name,
      required String email,
      required String phone,
      required String uId}) {
    UserModel user = UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        profileImage:
            "https://th.bing.com/th/id/OIP.5KCPS2N50OOkpn--n6uzggHaMB?pid=ImgDet&rs=1",
        bio: "Write your bio ...",
        coverImage:
            "https://nmaahc.si.edu/sites/default/files/styles/featured_image_16x9/public/images/header/audience-citizen_0.jpg?itok=yoGQec7Q");

    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      emit(SocialCreateUserInFirestoreState(uId));
    }).catchError((e) {
      emit(SocialErrorDuringCreateUserInFirestoreState(e.toString()));
    });
  }
}
