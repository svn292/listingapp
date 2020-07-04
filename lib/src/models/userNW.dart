import 'package:daangor/src/util/constants.dart';

class UserModel {
  UserModel(this.name, this.email, this.address, this.phone, this.profileImage);

  String name;
  String email;
  String address;
  String phone;
  String profileImage;

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    profileImage = json['profile_image'] == null ? kThumbnailsPic : json['profile_image'];
  }
}
