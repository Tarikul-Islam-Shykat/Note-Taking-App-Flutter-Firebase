import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter_firebase/views/homeScreen.dart';



signUpUser_service_(String userName, String userPhone, String userEmail, String userPassword) async{

  User? userId = FirebaseAuth.instance.currentUser;
  try{
    await FirebaseFirestore.instance.collection("users").doc(userId!.uid).set({ // setting the document based on the user id
      'userName':userName,
      'userPhone':userPhone,
      'userEmail':userEmail,
      'createdAt':DateTime.now(),
      'userId':userId!.uid,
    }).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(() => HomeScreen()),
    });
  } on FirebaseAuthException catch(e){
    print("error $e");
  }

}