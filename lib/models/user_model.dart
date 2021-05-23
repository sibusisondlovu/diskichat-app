import 'package:diski_live/models/team_model.dart';

class UserModel{
  String displayName;
  String email;
  String photoUrl;
  int coins;
  int followers;
  int following;
  String createdAt;
  String lastLogin;
  String level;
  //TeamModel team;

  UserModel({
   this.displayName, this.email, this.photoUrl, this.coins, this.followers,
    this.following, this.createdAt, this.lastLogin, this.level, //this.team
  });
}