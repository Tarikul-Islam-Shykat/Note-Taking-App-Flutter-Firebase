import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CREATE_NOTE extends StatefulWidget {
  const CREATE_NOTE({Key? key}) : super(key: key);

  @override
  State<CREATE_NOTE> createState() => _CREATE_NOTEState();
}

class _CREATE_NOTEState extends State<CREATE_NOTE> {

  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Create Notes"),),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            
            Container(
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Write Notes"),
              ),
            ),
            
            ElevatedButton(onPressed: () async{
              var note = noteController.text.trim();
              if(note.isEmpty){
                print("Please enter something");
              }
              else
                {
                  try{
                    await FirebaseFirestore.instance.collection("notes").doc().set({
                      "createdAt":DateTime.now(),
                      "note": note,
                      "userId":userId?.uid,
                    });
                  } catch(e){
                    print("Error $e");
                  }

                }
            }, child: Text("Add Note"))

            ],
        ),),

    );
  }
}
