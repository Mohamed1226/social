import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:man_chatting/model/models/message_model.dart';

import 'package:man_chatting/model/models/post_model.dart';

import 'package:man_chatting/model/models/user_model.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/view/home_screen.dart';
import 'package:man_chatting/view/nav_bar_view/chat.dart';
import 'package:man_chatting/view/nav_bar_view/feeds.dart';
import 'package:man_chatting/view/nav_bar_view/posts.dart';
import 'package:man_chatting/view/nav_bar_view/nav_user.dart';
import 'package:man_chatting/view/nav_bar_view/setting.dart';

import '../../constant.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel model = UserModel(
      isEmailVerified: false,
      email: "",
      name: "",
      phone: "",
      uId: "",
      profileImage: "",
      coverImage: "",
      bio: "");

  void getUser() async {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      var data = value.data();
      model = data != null ? UserModel.fromJson(data) : model;

      emit(SocialGetUserSuccessState());
    }).catchError((e) {
      emit(SocialGetUserErrorState(e.toString()));
    });
  }

  late List<UserModel> users = [];

  void getAllUser() async {
    print("index 111");
    emit(SocialGetAllUSerLoading());

    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element.data()["uId"] != model.uId) {
          users.add(UserModel.fromJson(element.data()));
        }

        emit(SocialGetAllUSerSuccess());
      });
    }).catchError((e) {
      emit(SocialGetAllUSerError());
    });
  }

  List<String> titles = ["Home", "Chats", "Add Post", "Users", "Settings"];
  List<Widget> navBarViews = [
    NavFeeds(),
    Chatting(),
    Post(),
    NavUsers(),
    NavSetting(),
  ];

  List<BottomNavigationBarItem> navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Chats"),
    BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Post"),
    BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle_sharp), label: "Users"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    if (index == 1) {
      print("index 1");
      getAllUser();
    }
    currentIndex = index;
    emit(SocialChangeBotNavBarState());
  }

  final ImagePicker _picker = ImagePicker();
  File? profileImage;

  Future getProfileImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialChangeProfileImageSuccessState());
    } else {
      print("no selected image");
      emit(SocialChangeProfileImageErrorState());
    }
  }

  File? coverImage;

  Future getCoverImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialChangeCoverImageSuccessState());
    } else {
      print("no selected image");
      emit(SocialChangeCoverImageErrorState());
    }
  }

  String? profileImageUrl;

  void uploadFileProfile() {
    emit(SocialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/#${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImageSuccessState());

        print(value);
        profileImageUrl = value;
      }).catchError((e) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;

  void uploadFileCover() {
    emit(SocialUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/#${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        emit(SocialUploadCoverImageSuccessState());

        print(value);
        coverImageUrl = value;
      }).catchError((e) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser(
      {required String name,
      required String bio,
      required String phone,
      String? profile,
      String? cover}) {
    emit(SocialUSerUpdateLoading());
    print("kkkkkkkkkkkkkkkkkkkk");
    print(model.coverImage);

    UserModel user = UserModel(
      name: name,
      phone: phone,
      coverImage: cover ?? model.coverImage,
      email: model.email,
      isEmailVerified: model.isEmailVerified,
      profileImage: profile ?? model.profileImage,
      uId: model.uId,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(model.uId)
        .update(user.toMap())
        .then((value) {
      getUser();
    }).catchError((e) {
      emit(SocialUSerUpdateError());
    });
  }

  //add post
  File? postImage;

  Future getPostImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialChangePostImageSuccessState());
      uploadFilePostImage();
    } else {
      print("no selected image");
      emit(SocialChangePostImageErrorState());
    }
  }

  String? postImageUrl;

  void uploadFilePostImage() {
    emit(SocialUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/#${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        emit(SocialUploadPostImageSuccessState());

        print(value);
        postImageUrl = value;
      }).catchError((e) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((e) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createNewPost(
      {required String dateTime,
      required String text,
      required BuildContext context}) {
    emit(SocialCreatePostLoadingState());
    print("lllllllllllllllll");
    print(model.name);
    PostModel post = PostModel(
        name: model.name,
        uId: model.uId,
        image: model.profileImage,
        dateTime: dateTime,
        text: text,
        postImage: postImageUrl ?? "");
    FirebaseFirestore.instance
        .collection("posts")
        .add(post.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
      print("successsssssssssssssss");
    }).catchError((e) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    postImageUrl = "";
    emit(SocialRemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() async {
    emit(SocialGetPostLoadingState());

    FirebaseFirestore.instance.collection("posts").get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("comments").get().then((value) {
          comments.add(value.docs.length);
        }).catchError((onError) {});

        element.reference.collection("likes").get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostSuccessState());
        }).catchError((e) {});
      });
    }).catchError((e) {
      emit(SocialGetPostErrorState());
    });
  }

  void likePost(String postId) {
    print("fffffffffffffffffff1111");
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(model.uId)
        .set({'like': true}).then((value) {
      print("fffffffffffffffffff22222");
      emit(SocialLikePostSuccessState());
    }).catchError((e) {
      emit(SocialLikePostErrorState());
      print("fffffffffffffffffff3333333");
    });
  }

  void commentPost(String postId, String text) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(model.uId)
        .set({'comment': text}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((e) {
      emit(SocialCommentPostErrorState());
    });
  }

  List<String> commentsText = [];

  void getPostComments(String postId) async {
    emit(SocialGetCommentPostSuccessState());
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        commentsText.add(element.data()["comment"]);
        print("lllllllllll");
        print(element.data()["comment"]);
        emit(SocialGetCommentPostSuccessState());
      });
    }).catchError((e) {
      emit(SocialGetCommentPostErrorState());
    });
  }

  //Chatting
  void sendMessage({required receiverId, required text, required dateTime}) {
    MessageModel message = MessageModel(
        receiverId: receiverId,
        senderId: model.uId,
        text: text,
        dateTime: dateTime);
    FirebaseFirestore.instance
        .collection("users")
        .doc(model.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((e) {
      emit(SocialSendMessageError());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(model.uId)
        .collection("messages")
        .add(message.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((e) {
      emit(SocialSendMessageError());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({required receiverId}) {

    print("dola1");
    print(model.uId);

    FirebaseFirestore.instance
        .collection("users")
        .doc(model.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages").orderBy("dateTime")
        .snapshots()
        .listen((event) {
      messages = [];
      print("dola2");
      event.docs.forEach((element) {
        print("dola3");
        print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
      });
           print("finish");
              print("messages is => ${messages.length}");
      emit(SocialGetMessageSuccess());
    });
  }
}
