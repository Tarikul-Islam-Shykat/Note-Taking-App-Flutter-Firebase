import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter_firebase/views/createNote.dart';
import 'package:note_app_flutter_firebase/views/editNotes.dart';
import 'package:note_app_flutter_firebase/views/homeScreen.dart';

class DASHBOARD extends StatefulWidget {
  const DASHBOARD({Key? key}) : super(key: key);

  @override
  State<DASHBOARD> createState() => _DASHBOARDState();
}

class _DASHBOARDState extends State<DASHBOARD> {

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Get.to(() => HomeScreen());
            },
              child: Icon(Icons.logout)
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(() => CREATE_NOTE());
      },child: Icon(Icons.add),),

      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("notes").where("userId", isEqualTo: userId?.uid).snapshots(),
          builder:(context, AsyncSnapshot<QuerySnapshot> snapshot){

            if(snapshot.hasError){
              return Text("There was an error retreving the data");
            }

            if(snapshot.connectionState == ConnectionState.waiting){ // if its wating to recevie the data
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if(snapshot.data!.docs.isEmpty){
              return Text("No Data Found!");
            }

            if(snapshot != null && snapshot.data != null){
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){

                    var note = snapshot.data!.docs[index]['note'];
                    var noteId = snapshot.data!.docs[index]['userId'];
                    var docId = snapshot.data!.docs[index].id;

                    return Card(
                      child: ListTile(
                        title: Text(note),
                        subtitle: Text(noteId),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            GestureDetector(
                              onTap: (){
                                Get.to(()=> EditNotesScreen(),
                                  arguments:{ // sending data to other screen
                                  'note':note,'docId': docId,
                                  }
                                );
                              },
                                child: Icon(Icons.edit)
                            ),

                            SizedBox(width: 10.0,),

                            GestureDetector( onTap: () async{
                              FirebaseFirestore.instance.collection("notes").doc(docId).delete(); // for deleting
                            },
                                child: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    );

                  });
            }


            return Container();
          } ,

        ),
      ),

    );

  }
}
