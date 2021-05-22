import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {

  final error;

  ErrorScreen({
    this.error
  });
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/error.png', width: 100, height: 100,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:18.0),
              child: Text(widget.error.toString()),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                  onPressed: (){

                  },
                  child: Text('Close')),
            )
          ],
        ),
      ),
    ));
  }
}
