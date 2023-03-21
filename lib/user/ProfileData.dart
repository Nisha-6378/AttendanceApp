import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';


import 'DashBoardScreen.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({super.key});
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userName ;
  var userEmail;
  var userPass ;
  @override
  void initState() {
    // TODO: implement initState
    if(mounted) {
      _getData();
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(

          child:Column(
            children:[
              FutureBuilder (
                  future: _getData() ,
                  builder:(context,snapshot) {
                   return Column(

                      children: [
                            Text('Name : $userName'),
                            Text('Email : $userEmail'),
                            Text('password: $userPass'),
                       ],
                    );
                  }),
              const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: () {
                        Navigator.pushNamed(
                            context, RoutesName.change);
                        } , child: const Text("Change Password")),

                      ElevatedButton(onPressed: () {
                        signOut();
                      },
                          child: const Text("LogOut",
                            style: TextStyle(color: Colors.red),))
                    ],
                  ),
             ],
         )
      ),
    );
  }
  Future<void>_getData() async {
    User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
        .collection('Users')
        .doc(user?.uid).snapshots()
        .listen((userData) {
      if (mounted) {
        setState(() {
          userName =userData.data()?['name'] ;
          userEmail =userData.data()?['email'];
          userPass = userData.data()?['password'];

        });
      }
    });
  }

  /// LogOut Function
  void signOut() {
     FirebaseAuth.instance.signOut();
     Fluttertoast.showToast( msg: 'You Have LogOut ');
     Navigator.pushNamed(context, RoutesName.login);
  }
}

