
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
              print('Document data: ${documentSnapshot.data()}');
              _userModel.displayName =  'My username';
            } else {
              print('Document does not exist on the database');
              _userModel = UserModel(
                  displayName: 'Sibusiso Testing',
                  coins: 0,
                  createdAt: '152030403040506',
                  followers: 100,
                  following: 493,
                  lastLogin: '16499393949559',
                  level: 'SEMI-PRO',
                  photoUrl: '',
                  email: 'sibusiso@ndlovuy.com',
              );
            }
          }).catchError((onError) {
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