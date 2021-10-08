import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man_chatting/model/models/user_model.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';

class ChattingDetails extends StatelessWidget {
  UserModel user;
  TextEditingController messageController = TextEditingController();

  ChattingDetails(this.user);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      //   print("user.uid ${user.uId}");

      // print("my Id ${SocialCubit.get(context).model.uId}");
      SocialCubit.get(context).getMessage(receiverId: user.uId);
      //  print("the len is ${SocialCubit.get(context).messages.length}");
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.profileImage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          user.name,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (SocialCubit.get(context).messages.length >= 0)
                      Expanded(
                        child: ListView.builder(
                            itemCount: SocialCubit.get(context).messages.length,
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).messages[index];
                              if (message.senderId ==
                                  SocialCubit.get(context).model.uId) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      margin: EdgeInsets.all(1),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                            bottomEnd: Radius.circular(20),
                                            topEnd: Radius.circular(20),
                                            topStart: Radius.circular(20),
                                          )),
                                      child: Text(message.text)),
                                );
                              } else {
                                return Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: Colors.cyan,
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                            bottomStart: Radius.circular(20),
                                            topEnd: Radius.circular(20),
                                            topStart: Radius.circular(20),
                                          )),
                                      child: Text(message.text)),
                                );
                              }
                            }),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Chat With Your Friends",
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                  receiverId: user.uId,
                                  text: messageController.text,
                                  dateTime: DateTime.now().toString());
                              messageController.text = "";
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            elevation: 0,
                            color: Colors.greenAccent,
                            height: 51,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }
}
