class UserModel {
  late final String email;
  late final String name;
  late final String phone;
  late final String uId;
  late bool isEmailVerified;
  late String profileImage;
  late String coverImage;
  late String bio;
  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
    required this.profileImage,
    required this.coverImage,
    required this.bio,

  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    profileImage = json['profileImage'];
    coverImage = json['coverImage'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'bio': bio,
    };
  }
}
