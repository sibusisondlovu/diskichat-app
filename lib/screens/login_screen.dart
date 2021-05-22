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
  @override
  Widget build(BuildContext context) {

    LoginService _loginService = Provider.of<LoginService>(
        context,
        listen: false
    );

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Image.asset('assets/images/backgrounds/sign_in_bg.jpg'),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Welcome \nChoose sign in method to continue'),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(onPressed: () async {
                          bool success = await _loginService.signInWithGoogle();

                          if (success) {
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
                        width: MediaQuery.of(context).size.width * 0.7,
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
                      Text('Terms and conditions, privacy policy acknowledgement'),
                    ],
                  ),
                  Text('Don\'t have an account? Sign Up'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
