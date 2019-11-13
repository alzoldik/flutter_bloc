import 'package:user/model/location.dart';
import 'package:user/model/name.dart';
import 'package:user/model/picture.dart';

class User {
  final Name name;
  final Location location;
  final String email;
  final Picture picture;

  User(this.name, this.location, this.email, this.picture);

  User.fromJson(Map<String, dynamic> json)
      : name = Name.fromJson(json["name"]),
        location = Location.fromJson(json["location"]),
        email = json["email"],
        picture = Picture.fromJson(json["picture"]);
}
