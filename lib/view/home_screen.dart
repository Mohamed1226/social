import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man_chatting/model/cash_helper.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';
import 'package:man_chatting/view/add_post.dart';

import 'package:man_chatting/view/sign_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUser(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
        if(SocialCubit.get(context).currentIndex ==2){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return AddPost();
          }));
        }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          var model = cubit.model;
          return Scaffold(
          //  backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                     CacheHelper.prefs.clear();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LogInScreen();
                    }));
                  },
                  icon: Icon(Icons.logout),
                )
              ],
              title: Text(
                cubit.titles[cubit.currentIndex],
                // style:
                //     TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                      //     margin:EdgeInsets.symmetric(horizontal: 15.0),
                      color: Colors.black.withOpacity(0.6),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                              child: Text(
                            "Please Verify Your Email",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          )),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification()
                                    .then((value) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Check Your Email"),
                                        );
                                      });
                                }).catchError((e) {});
                              },
                              child: Text("Send")),
                        ],
                      ),
                    ),
                  cubit.navBarViews[cubit.currentIndex]
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navBarItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
