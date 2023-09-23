import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Authenticate/Autheticate.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pheonix',
      theme: ThemeData(
        primarySwatch: Colors.red ,
      ),home: Authenticate(),
    );
  }
}
