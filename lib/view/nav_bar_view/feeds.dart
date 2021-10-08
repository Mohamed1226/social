import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:man_chatting/model/models/post_model.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';
import 'package:man_chatting/view/comments_screen.dart';

class NavFeeds extends StatelessWidget {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUser()
        ..getPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, index) {},
          builder: (context, index) {
            return Column(
              children: [
                Card(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        image: NetworkImage(
                          "https://nmaahc.si.edu/sites/default/files/styles/featured_image_16x9/public/images/header/audience-citizen_0.jpg?itok=yoGQec7Q",
                        ),
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Communicate With Your Friends",
                          // style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 20.0,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                SocialCubit.get(context).posts.length > 0
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.0,
                          );
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return itemBuilder(
                              SocialCubit.get(context).posts[index],
                              context,
                              index);
                        },
                        itemCount: SocialCubit.get(context).posts.length,
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            );
          }),
    );
  }

  Widget itemBuilder(PostModel post, context, int index) {

 
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Card(
              elevation: 0,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      post.image,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            post.name,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.check_circle_sharp,
                            color: Colors.blueAccent,
                            size: 17,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Icon(
                            Icons.arrow_downward,
                          ),
                        ],
                      ),
                      Text(post.dateTime),
                  //    Text(DateFormat.yMMMMd(DateTime.parse(post.dateTime)).toString()),


                   //   Text(),
                    ],
                  ),
                ],
              )),
          Container(
            width: 370,
            child: Divider(
              color: Colors.black,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 3),
            elevation: 0.2,
            child: Text(
              post.text,
              style: TextStyle(fontWeight: FontWeight.w500, height: 1),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            height: 35,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            width: double.infinity,
            child: Wrap(
              spacing: 0,
              children: [
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.blue,
                  elevation: 0,
                  child: Text("#software"),
                ),
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.blue,
                  elevation: 0,
                  child: Text("#English"),
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 0,
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.blue,
                  elevation: 0,
                  child: Text("#Articles"),
                ),
              ],
            ),
          ),
          if (post.postImage != "")
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Image(
                image: NetworkImage(post.postImage),
                fit: BoxFit.cover,
                height: 170,
                width: double.infinity,
              ),
            ),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  minWidth: 0,
                  onPressed: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  color: Colors.white,
                  textColor: Colors.blue,
                  elevation: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.recommend,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${SocialCubit.get(context).likes[index]}",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.only(right: 6),
                  minWidth: 0,
                  onPressed: () {
                    SocialCubit.get(context).getPostComments( SocialCubit.get(context).postsId[index]);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CommentsScreen(
                          SocialCubit.get(context).postsId[index]);
                    }));
                  },
                  color: Colors.white,
                  textColor: Colors.blue,
                  elevation: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${SocialCubit.get(context).comments[index]} Comment",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: 1,
            width: 370,
            child: Divider(
              color: Colors.black,
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(SocialCubit.get(context).model.profileImage),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 190,
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Write a Comment ...",
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (v) {
                      SocialCubit.get(context).commentPost(
                          SocialCubit.get(context).postsId[index], v);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 0,
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.blue,
                  elevation: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
