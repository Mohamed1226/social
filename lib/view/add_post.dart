import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';
import 'package:man_chatting/view/home_screen.dart';

class AddPost extends StatelessWidget {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUser(),
      child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var postImage = SocialCubit.get(context).postImage;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Add New Post",
                  style: TextStyle(color: Colors.black),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){return HomeScreen();}));
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      SocialCubit.get(context).createNewPost(
                          dateTime: DateTime.now().toString(),
                          text: textController.text,
                          context: context);
                    },
                    child: Text(
                      "POST",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=333&q=80",
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Mohamed Adel",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.check_circle_sharp,
                                  color: Colors.blueAccent,
                                  size: 17,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                            hintText: "Think And Post ...",
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (postImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image(
                            fit: BoxFit.fill,
                            height: 200,
                            width: double.infinity,
                            image: FileImage(postImage),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removePostImage();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.camera_alt_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Add Photo"),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("#tags"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
