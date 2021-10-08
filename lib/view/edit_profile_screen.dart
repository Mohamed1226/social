import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:man_chatting/model_view/social_cubit/scial_states.dart';
import 'package:man_chatting/model_view/social_cubit/social_cubit.dart';

import 'custom_widget/custom_text_form_field.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUser(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;
          var model = SocialCubit.get(context).model;
          nameController.text = model.name;
          phoneController.text = model.phone;
          bioController.text = model.bio;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Edit Your Profile",
                style: TextStyle(color: Colors.black),
              ),
              titleSpacing: 0,
              actions: [
                TextButton(
                    onPressed: () {
                      print("llllllllllllllllllllll");
                      print(nameController.text);
                      print(bioController.text);
                      print(phoneController.text);
                      print("llllllllllllllllllllll");

                      SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                        cover: SocialCubit.get(context).coverImageUrl,
                        profile: SocialCubit.get(context).profileImageUrl,
                      );

                    },
                    child: Text("UPDATE")),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is SocialUSerUpdateLoading)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.all(8),
                      height: 200,
                      child: Stack(
                        alignment: Alignment(0, 2.5),
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Image(
                                fit: BoxFit.fill,
                                height: 200,
                                width: double.infinity,
                                image: coverImage == null
                                    ? NetworkImage(
                                        model.coverImage,
                                      )
                                    : FileImage(coverImage) as ImageProvider,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 18,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              SocialCubit.get(context).getProfileImage();
                            },
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(model.profileImage)
                                      : FileImage(profileImage)
                                          as ImageProvider,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 18,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              ElevatedButton(
                                child: Text("Upload Profile"),
                                onPressed: () {
                                  SocialCubit.get(context).uploadFileProfile();
                                },
                              ),
                              if (state is SocialUploadProfileImageLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 5,
                        ),
                        if (coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              ElevatedButton(
                                child: Text("Upload cover"),
                                onPressed: () {
                                  SocialCubit.get(context).uploadFileCover();
                                },
                              ),
                              if (state is SocialUploadCoverImageLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextFormField(
                        prefix: Icon(Icons.person_add_alt),
                        controller: nameController,
                        obsure: false,
                        type: TextInputType.name,
                        validate: (val) {
                          if (val.toString().isEmpty) {
                            return "please input your Name";
                          }
                        },
                        label: "Update your Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextFormField(
                        prefix: Icon(Icons.alternate_email),
                        controller: bioController,
                        obsure: false,
                        type: TextInputType.text,
                        validate: (val) {
                          if (val.toString().isEmpty) {
                            return "please input your bio";
                          }
                        },
                        label: "Update Your Bio"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextFormField(
                        prefix: Icon(Icons.phone),
                        controller: phoneController,
                        obsure: false,
                        type: TextInputType.text,
                        validate: (val) {
                          if (val.toString().isEmpty) {
                            return "please input your phone";
                          }
                        },
                        label: "Update YOur Phone"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
