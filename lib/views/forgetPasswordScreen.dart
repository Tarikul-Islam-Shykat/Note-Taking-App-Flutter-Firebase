import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_firebase/views/homeScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController forgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Forget Password"),
      ),

      body:
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Container( height: 200.0, alignment:  Alignment.center,
                child: Image.asset("assets/lottie/forget_password.png"),
              ),


              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller:  forgetPasswordController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email), // adds icon in the end
                    hintText: "Email",
                    enabledBorder:  OutlineInputBorder(),
                  ),
                ),
              ), SizedBox(height: 10.0,),

              ElevatedButton(
                  onPressed: () async {
                    var forgotMail = forgetPasswordController.text.trim();
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotMail).then((value) => { // this will send an email to your mail for changing password.
                        Get.off(() => HomeScreen()),
                      });
                    } on FirebaseAuthException catch(e){

                    }


                  },
                  child: Text("Forget Password")
              ), SizedBox(height: 10.0,),


            ],
          ),
        ),
      ),
    );
  }
}


