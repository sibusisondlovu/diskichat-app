
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diski_live/models/user_model.dart';
import 'package:flutter/material.dart';

class FirebaseMethodsServices {
  UserModel _userModel;
  UserModel get userModelProfile =>_userModel;

  getUserProfileInformation(uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot.data()}');
              _userModel.displayName =  'My username';
            } else {
              print('Document does not exist on the database');
              _userModel.displayName =  'My username';
            }
          });
  }
}