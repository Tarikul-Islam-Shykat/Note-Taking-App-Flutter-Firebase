import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter_firebase/views/dashBoard.dart';

class EditNotesScreen extends StatefulWidget {
  const EditNotesScreen({Key? key}) : super(key: key);

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  TextEditingController note_edit_contreoller  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Edit Notes"),
      ),

      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller:  note_edit_contreoller..text = "${Get.arguments['note'].toString()}", // see 2 dots // argument coming from dashboard.

            ),
            ElevatedButton(onPressed: () async {
              await FirebaseFirestore.instance.collection("notes").doc(Get.arguments['docId'].toString()).update({
                'note':note_edit_contreoller.text.trim()
              }).then((value) => {
                Get.offAll(() => DASHBOARD())
              });
            }, child: Text("Updae"))
          ],
        ),
      ),
    );
  }
}
