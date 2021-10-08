abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialChangeBotNavBarState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeProfileImageSuccessState extends SocialStates {}

class SocialChangeProfileImageErrorState extends SocialStates {}

class SocialChangeCoverImageSuccessState extends SocialStates {}

class SocialChangeCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUSerUpdateLoading extends SocialStates {}
class SocialUSerUpdateSuccess extends SocialStates{}
class SocialUSerUpdateError extends SocialStates {}

//add post
class SocialChangePostImageSuccessState extends SocialStates {}

class SocialChangePostImageErrorState extends SocialStates {}

class SocialUploadPostImageLoadingState extends SocialStates {}

class SocialUploadPostImageSuccessState extends SocialStates {}

class SocialUploadPostImageErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {}

//like post

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {}

//comment post

class SocialCommentPostSuccessState extends SocialStates {}

class SocialCommentPostErrorState extends SocialStates {}


class SocialGetCommentPostSuccessState extends SocialStates {}

class SocialGetCommentPostErrorState extends SocialStates {}

//get all user

class SocialGetAllUSerLoading extends SocialStates {}
class SocialGetAllUSerSuccess extends SocialStates{}
class SocialGetAllUSerError extends SocialStates {}

class SocialSendMessageSuccess extends SocialStates{}
class SocialSendMessageError extends SocialStates {}


class SocialGetMessageSuccess extends SocialStates{}
class SocialGetMessageError extends SocialStates {}