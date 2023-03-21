import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/firebase_options.dart';
import 'package:login_firebase_flutter/routes/routes.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';
import 'package:login_firebase_flutter/user/splashServices.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var value=prefs.getString("value");
  runApp(const MyApp());

}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splash,
         onGenerateRoute: Routes.generateRoute,
        home: SplashScreen()
    );
  }

}


class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> {
   SplashServices splashScreen= SplashServices();

  @override
  void initState() {

    //if( IsLogOut.isPunchIn==false){
      //navigateLoginScreen();
    //}
   splashScreen.isLogin(context);
    super.initState();
  }
  navigateLoginScreen() async {
    await Future.delayed(Duration(microseconds: 4000), () {
      Navigator.pushNamed(context, RoutesName.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(

              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: const Text(
                  "Splash Screen",
                  textAlign: TextAlign.start,
                ),
              ),

        // AppBar
        body:Center(

            child: Container(
                height: 150,
                width: 150,
                child: Image.asset('assets/images/spanidea.jpg')
            )
        )

    )
    );
  }
}












