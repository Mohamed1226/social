import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:man_chatting/model/cash_helper.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';
import 'package:man_chatting/services/theme_ervice.dart';
import 'package:man_chatting/view/native_code_screen.dart';

import 'model_view/login_cubit/login_cubit.dart';
import 'view/home_screen.dart';
import 'view/sign_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print("token $token");
  FirebaseMessaging.onMessage.listen((event) {
    print("onMessage");
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("onMessageOpenedApp");
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);


  await CacheHelper.init();
  Widget widget;
  var uId = CacheHelper.getData("uId");

  if (uId != null) {
    widget = HomeScreen();
  } else {
    widget = LogInScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUser()
              ..getPosts()),
        BlocProvider(create: (context) => CubitLogIn()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        darkTheme: ThemeService.dark,
        theme: ThemeService.light,
        home: NativeCodeScreen(),
      ),
    );
  }
}


Future<void> firebaseMessagingHandler(RemoteMessage message)async{
  print("onBackGround");
  print(message.data.toString());

}