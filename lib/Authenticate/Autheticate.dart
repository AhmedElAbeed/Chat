import 'package:chat_v2/Screens/HomeScreen.dart';
import 'package:chat_v2/Screens/Navin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return MyHomePage();
    } else {
      return LoginScreen();
    }
  }
}
