import 'package:diski_live/services/firebase_methods_service.dart';
import 'package:diski_live/services/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _profileHeader(context)
    ));
  }


  Widget _profileHeader(BuildContext context) {

    LoginService _loginService = Provider.of<LoginService>(
        context,
        listen: false
    );

    FirebaseMethodsServices _firebaseMethods = Provider.of<FirebaseMethodsServices>(
        context,
        listen: false
    );

    _firebaseMethods.getUserProfileInformation(FirebaseAuth.instance.currentUser.uid, context);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(150)),

              child: Image.network(
                _loginService.loggedInUserModel.photoUrl,
                fit: BoxFit.cover,
                width: 150, height: 150,)),
          Text(_loginService.loggedInUserModel.email,
            style: TextStyle(fontSize: 13),
          ),
          Text(
            _firebaseMethods.userModelProfile.displayName,
            style: TextStyle(fontSize: 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                        _firebaseMethods.userModelProfile.coins.toString(),
                          style: TextStyle(fontSize: 28),
                        ),
                        Text('COINS')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          _firebaseMethods.userModelProfile.followers.toString(),
                          style: TextStyle(fontSize: 28),
                        ),
                        Text('FOLLOWERS')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          _firebaseMethods.userModelProfile.following.toString(),
                          style: TextStyle(fontSize: 28),
                        ),
                        Text('FOLLOWING')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Text(
            'My Team',
            style: TextStyle(fontSize: 14),
          ),
          Card(
            child: ListTile(
              leading: Image.network(_firebaseMethods.userModelProfile.team.teamLogo),
              title: Text(_firebaseMethods.userModelProfile.team.teamName),
              subtitle: Text(_firebaseMethods.userModelProfile.team.league),
              trailing: Icon(Icons.edit),
            ),
          )
        ],
      ),
    );
  }

}
