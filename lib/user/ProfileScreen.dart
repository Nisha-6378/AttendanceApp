
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:login_firebase_flutter/routes/routes_name.dart';


///  Display All user Detail from Firebase 

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key}) : super(key: key);
  @override
  State<ProfileData> createState() => _ProfileDataState();
}
class _ProfileDataState extends State<ProfileData> {
  final auth = FirebaseAuth.instance;
  

   final ref=  FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async{
      return false;
    },
      child:Scaffold(
      body:
        StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder:(context,AsyncSnapshot snapshot){

            
            if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
            }
                           
            return ListView.builder(
                  itemCount: snapshot.data!.docs.length,

                  itemBuilder: (context, int i) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      height: 180,
                      color: Colors.pink,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text("Name: ${snapshot.data!.docs[i]['name']}"),
                            const SizedBox(height: 5),
                            //Text("Name: ${snapshot.data!['email']}"),
                            Text("Email: ${snapshot.data!.docs[i]['email']} "),
                            const SizedBox(height: 5),
                            //Text("Name: ${snapshot.data!['password']}"),
                            Text("Password: ${snapshot.data!
                                .docs[i]['password']}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.change);
                                }, child: const Text("Change Password")),

                                ElevatedButton(onPressed: () {
                                  //signOut();

                                },
                                    child: const Text("LogOut",
                                      style: TextStyle(color: Colors.red),))
                              ],
                            ),
                            const SizedBox(height: 5,)]),
                    );
             });
            
            
          },
       )

    ),
    );
  }
}
