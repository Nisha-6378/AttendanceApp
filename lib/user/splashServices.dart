// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/servicess/SessionControoler.dart';
import '../routes/routes_name.dart';
class SplashServices{
  Future<void> isLogin (BuildContext context) async {
    final auth= FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user!=null){
      SessionController().userId=user.uid.toString();
      print('userid ${SessionController().userId}');
      await Future.delayed(const Duration(microseconds: 5000), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, RoutesName.dashboard);
        });
      });

    }
    else{
      await Future.delayed(const Duration(microseconds: 5000), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, RoutesName.login);
        });
      });
    }
  }

}