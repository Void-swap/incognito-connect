import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:incognito_connect/view/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //for APP initialize in main & web in future
      options: const FirebaseOptions(
          apiKey: "AIzaSyBAiSY7QiQPyXmP9Hfo1S2GcR7WM2vyokQ",
          projectId: "incognito-connent",
          messagingSenderId: "24247078499",
          appId: "1:24247078499:web:29464de9d60a4a430a7256"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoarding(),
    );
  }
}
