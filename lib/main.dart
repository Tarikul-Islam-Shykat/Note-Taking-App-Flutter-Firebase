import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter_firebase/views/dashBoard.dart';
import 'package:note_app_flutter_firebase/views/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // this will check if the all the necessary dependency is installed and then go and execute rest( async )
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override // this is the function that is called when ever the app runs
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: user != null ? DASHBOARD() : HomeScreen(), // my home screen is my login screen

    );
  }
}
