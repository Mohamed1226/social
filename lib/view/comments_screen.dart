import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';

class CommentsScreen extends StatelessWidget {
  String postId;

  CommentsScreen(this.postId);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getPostComments(postId),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Comments",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SocialCubit.get(context).commentsText.length > 0
                ? ListView.builder(
                    itemCount: SocialCubit.get(context).commentsText.length,
                    itemBuilder: (context, index) {
                      return Card(
                        
                        color: Colors.grey.shade50,
                        margin: EdgeInsets.all(8.0),
                        elevation: .6,
                        child: Center(
                          child: Text(
                              SocialCubit.get(context).commentsText[index],style: TextStyle(
                            fontSize: 18.0,fontWeight: FontWeight.bold
                          ),),
                        ),
                      );
                    })
                : Center(
                    child: Text(" NO Comments"),
                  ),
          );
        },
      ),
    );
  }
}
