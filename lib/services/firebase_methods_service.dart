
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diski_live/models/team_model.dart';
import 'package:diski_live/models/user_model.dart';
import 'package:diski_live/screens/error_screen.dart';
import 'package:flutter/material.dart';

class FirebaseMethodsServices {
  UserModel _userModel;
  UserModel get userModelProfile =>_userModel;

  getUserProfileInformation(uid, BuildContext context) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot['team']['teamLogo']}');

              TeamModel teamModel = new TeamModel ();

              teamModel.teamLogo = documentSnapshot['team']['teamLogo'];
              teamModel.teamName = documentSnapshot['team']['teamName'];
              teamModel.league = documentSnapshot['team']['league'];

              _userModel = UserModel(
                displayName: documentSnapshot['displayName'],
                coins: documentSnapshot['coins'],
                createdAt: documentSnapshot['createdAt'],
                followers: documentSnapshot['followers'],
                following: documentSnapshot['following'],
                lastLogin: documentSnapshot['lastLogin'],
                level: documentSnapshot['level'],
                photoUrl: documentSnapshot['photoUrl'],
                email: documentSnapshot['email'],
                team: teamModel
              );

            } else {
              print('Document does not exist on the database');
            }
          }).catchError((onError) {
            print(onError);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ErrorScreen(error: onError)),
              );
          });
  }

  createUserProfile(uid, userData) async {
    await FirebaseFirestore.instance.collection('users')
        .doc(uid)
        .set(userData)
        .then((value) {
          // print success and continue with operation
          print('profile created successfully');
    })
        .catchError((onError){
          // print error
      print(onError.toString());
    });
  }
}