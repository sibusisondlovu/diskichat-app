import 'package:diski_live/models/login_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginService {
  LoginUserModel _loginUserModel;
  LoginUserModel get loggedInUserModel =>_loginUserModel;


  Future<bool> signInWithGoogle() async {
    // trigger the authentication flow
    GoogleSignIn  googleSignIn = GoogleSignIn();

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
    }

    return true;
  }

  void signOut() async {
    await GoogleSignIn().signOut();
    _loginUserModel = null;
  }
}