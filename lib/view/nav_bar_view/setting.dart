import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';
import 'package:man_chatting/view/edit_profile_screen.dart';

class NavSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialUSerUpdateSuccess) {
          SocialCubit.get(context).getUser();
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              elevation: 5,
              child: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.all(8),
                height: 200,
                child: Stack(
                  alignment: Alignment(0, 2),
                  children: [
                    Image(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 200,
                      image: NetworkImage(cubit.model.coverImage),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(cubit.model.profileImage),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(cubit.model.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
            SizedBox(
              height: 18,
            ),
            Text(cubit.model.bio),
            SizedBox(
              height: 23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "100",
                      style: TextStyle(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Posts",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("250"),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Friends",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("5K"),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Followers",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("89"),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Followings",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              //  width: 40,
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {}, child: Text("Add Photos"))),
                  SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfileScreen();
                        }));
                      },
                      child: Icon(Icons.edit)),
                ],
              ),
            ),
            Container(
              //  width: 40,
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  OutlinedButton(onPressed: () {
                    
                  //  FirebaseMessaging.instance.subscribeToTopic(topic)
                  }, child: Text("Subscribe")),
                  SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(onPressed: () {}, child: Text("UnSubscribe")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
