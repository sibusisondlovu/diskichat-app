import 'package:diski_live/main_layout.dart';
import 'package:diski_live/screens/home_screen.dart';
import 'package:diski_live/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isAuthenticating = false;

  @override
  Widget build(BuildContext context) {

    LoginService _loginService = Provider.of<LoginService>(
        context,
        listen: false
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_screen_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          ///crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset("assets/images/app_logo.png", width: 150, height: 150,),
            Text('Welcome to Diski Chat',
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),),
            isAuthenticating? SizedBox(
              height: 50,width: 50,
              child: CircularProgressIndicator(),
            ): Container(),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(onPressed: () async {

                    setState(() {
                      isAuthenticating = true;
                    });
                    bool success = await _loginService.signInWithGoogle();

                    if (success) {
                      setState(() {
                        isAuthenticating = false;
                      });
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(
                              builder: (context) => MainLayoutScreen() ));
                    }
                  },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Colors.redAccent;// Use the component's default.
                          },
                        ),
                      ),
                      child: Text(
                          'Sign In With Google'
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            return Colors.blueAccent;// Use the component's default.
                          },
                        ),
                      ),
                      child: Text(
                          'Sign In With Facebook'
                      )),
                ),
                Text('Terms and conditions, privacy policy acknowledgement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
                ),),
              ],
            ),
            Text('Don\'t have an account? Sign Up', textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white
            ),),
          ],
        ),
      ),
    );
  }
}
