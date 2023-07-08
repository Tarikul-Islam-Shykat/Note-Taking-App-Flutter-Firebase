import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app_flutter_firebase/views/dashBoard.dart';
import 'package:note_app_flutter_firebase/views/forgetPasswordScreen.dart';
import 'package:note_app_flutter_firebase/views/signUpScreen.dart';

// home screen is the login screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false, // remove the back button
        centerTitle: true,
        title: Text("Login"),
      ),

      body: 
      SingleChildScrollView(
        child: Container(
          child: Column(
          children: [

            Container( height: 250.0, alignment:  Alignment.center,
              child: Lottie.asset("assets/lottie/login.json"),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: loginEmailController,
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
                controller: loginPasswordController,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.password), // adds icon in the end
                  hintText: "Password",
                  enabledBorder:  OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 10.0,),

            ElevatedButton(
                onPressed: () async{
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginPasswordController.text.trim();
                  debugPrint("dsdfsaf");
                  try{
                    final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email:loginEmail , password: loginPassword)).user;
                    if(firebaseUser != null){
                      Get.to(()=> DASHBOARD());
                    }
                    else{
                      print("Not login in ");
                    }

                  } on FirebaseAuthException catch (e){
                    print("Error in loing $e");
                  }
                },
                child: Text("Login")
            ),

            SizedBox(height: 10.0,),

            GestureDetector(
              onTap: (){
                Get.to(()=>ForgetPasswordScreen());
              },
              child: Container(
                  child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Forget Passowrd ?"),
                      ))
              ),
            ),

            SizedBox(height: 10.0,),

            GestureDetector(
              onTap: (){
                Get.to(() => signUpScreen());
              },
              child: Container(
                  child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Don't Have An account ? Sign Up !"),
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
