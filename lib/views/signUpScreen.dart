import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_firebase/services/signUpServices.dart';
import 'package:note_app_flutter_firebase/views/homeScreen.dart';


class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  TextEditingController userNameController = TextEditingController(); // assigns the controller in the text input
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser; // storing the current user

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up"),
      ),

      body:
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Container( height: 250.0, alignment:  Alignment.center,
                child: Lottie.asset("assets/lottie/login.json", fit: BoxFit.cover),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userNameController, // id like android
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.verified_user), // adds icon in the end
                    hintText: "User Name",
                    enabledBorder:  OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPhoneController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.phone), // adds icon in the end
                    hintText: "Phone",
                    enabledBorder:  OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userEmailController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email), // adds icon in the end
                    hintText: "Email",
                    enabledBorder:  OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: userPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.password), // adds icon in the end
                    hintText: "Password",
                    enabledBorder:  OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(height: 10.0,),

              ElevatedButton(
                  onPressed: (){
                    // get the values
                    var userName = userNameController.text.trim();
                    var userPhone = userPhoneController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();

                    userNameController.clear();
                    userPhoneController.clear();
                    userEmailController.clear();
                    userPasswordController.clear();

                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: userPassword).then((value) =>
                    {
                      signUpUser_service_(userName,userPhone,userEmail,userPassword)
                    });
                  },
                  child: Text("Sign Up")
              ),


              SizedBox(height: 10.0,),

              GestureDetector(
                onTap: (){
                  Get.to(() => HomeScreen());
                },
                child: Container(
                  child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Already Have an account ?"),
                      )
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}

