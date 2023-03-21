import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttandenceApp{


  static  late SharedPreferences sharedPreferences;

  static const String name= 'name';
  static const String email='email';
  static const String password='password';

   static User? user= FirebaseAuth.instance.currentUser;
  static final ref =  FirebaseFirestore.instance.collection('Users').doc(user!.uid);


}