import 'package:flutter/material.dart';
import 'package:greenify_front/models/userModel.dart';
import 'package:greenify_front/screens/sign_up_pages/introductionOne.dart';
import 'package:greenify_front/screens/sign_up_pages/introductionTwo.dart';
import 'package:greenify_front/screens/sign_up_pages/userCredentials.dart';
import 'package:greenify_front/screens/sign_up_pages/userEmailChoice.dart';
import 'package:greenify_front/screens/sign_up_pages/userEmailCredential.dart';
import 'package:greenify_front/screens/sign_up_pages/userPassword.dart';
import 'package:greenify_front/screens/sign_up_pages/userTypeChoice.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => User(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Greenify',
      initialRoute: "/userTypeChoice",
      routes: {
        "/introductionOne": (context) => introductionOne(),
        "/introductionTwo": (context) => introductionTwo(),
        "/userTypeChoice": (context) => userTypeChoice(),
        "/userCredentials": (context) => userCredentials(),
        "/userEmailChoice": (context) => userEmailChoice(),
        "/userEmailCredential": (context) => userEmailCredential(),
        "/userPassword": (context) => userPassword(),
      },
    );
  }
}
