import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man_chatting/model/models/user_model.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';
import 'package:man_chatting/view/chat_details.dart';

class Chatting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel model = UserModel(
        isEmailVerified: false,
        email: "",
        name: "",
        phone: "",
        uId: "",
        profileImage: "",
        coverImage: "",
        bio: "");
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUser()
        ..getAllUser(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is SocialGetAllUSerLoading
              ? Center(
                  child: Text(
                    "please wait",
                    style: TextStyle(color: Colors.brown),
                  ),
                )
              : SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: SocialCubit.get(context).users.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            model = SocialCubit.get(context).users[index];
                            print(model.uId);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChattingDetails(model);
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    SocialCubit.get(context)
                                        .users[index]
                                        .profileImage,
                                  ),
                                ),
                                Text(
                                  SocialCubit.get(context).users[index].name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
        },
      ),
    );
  }
}
