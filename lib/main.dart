import 'package:diski_live/main_layout.dart';
import 'package:diski_live/screens/error_screen.dart';
import 'package:diski_live/screens/loading_screen.dart';
import 'package:diski_live/screens/login_screen.dart';
import 'package:diski_live/services/firebase_methods_service.dart';
import 'package:diski_live/services/login_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        Provider<LoginService>(create: (_) => LoginService()),
        Provider<FirebaseMethodsServices>(create: (_) => FirebaseMethodsServices()),
      ],
      child: MaterialApp(
        title: 'Diski Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return ErrorScreen(error: snapshot.error);
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return LoginScreen(); // replace with wrapper
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return LoadingScreen();
          },
        )),
    );
  }
}

