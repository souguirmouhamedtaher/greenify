import 'package:flutter/material.dart';
import 'package:greenify_front/models/userModel.dart';
import 'package:greenify_front/screens/sign_up_pages/introductionOne.dart';
import 'package:greenify_front/screens/sign_up_pages/introductionTwo.dart';
import 'package:greenify_front/screens/sign_up_pages/userTypeChoice.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => User(), // Provide an instance of User
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Greenify',
      initialRoute: "/userTypeChoice",
      routes: {
        "/introductionOne": (context) => introductionOne(),
        "/introductionTwo": (context) => introductionTwo(),
        "/userTypeChoice": (context) => userTypeChoice(),
      },
    );
  }
}
