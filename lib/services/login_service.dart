import 'package:diski_live/models/login_user_model.dart';
import 'package:diski_live/models/user_model.dart';
import 'package:diski_live/services/firebase_methods_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  LoginUserModel _loginUserModel;
  LoginUserModel get loggedInUserModel =>_loginUserModel;

  Future<bool> signInWithGoogle() async {
    // trigger the authentication flow
    GoogleSignIn  googleSignIn = GoogleSignIn();
    FirebaseMethodsServices _firebaseMethodsServices = FirebaseMethodsServices();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser == null){
      return false;
    }
    //obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    //create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    // once sign in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential !=null) {
      _loginUserModel = LoginUserModel(
          displayName: userCredential.user.displayName,
          photoUrl: userCredential.user.photoURL,
          email: userCredential.user.email
      );

      // create default user profile
      var userProfileInformation = {
        'displayName': userCredential.user.displayName,
        'coins': 0,
        'createdAt': '152030403040506',
        'followers': 100,
        'following': 493,
        'lastLogin': '16499393949559',
        'level': 'SEMI-PRO',
        'photoUrl': userCredential.user.photoURL,
        'email': userCredential.user.email,
        'team' : {
          'teamName': 'Amazulu FC',
          'teamLogo': 'https://img2.pngio.com/amazulu-football-club-in-football-manager-2019-amazulu-fc-png-180_180.png',
          'league': 'DSTV Premiership'
        }
      };

      _firebaseMethodsServices.createUserProfile(userCredential.user.uid, userProfileInformation);
    }

    return true;
  }

  void signOut() async {
    await GoogleSignIn().signOut();
    _loginUserModel = null;
  }
}