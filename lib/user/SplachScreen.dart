import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';
import 'package:login_firebase_flutter/user/splashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    //  navigateLoginScreen();
    splashScreen.isLogin(context);
    super.initState();
  }
  navigateLoginScreen() async {
    await Future.delayed(const Duration(microseconds: 4000), () {
      Navigator.pushNamed(context, RoutesName.login);
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      return false;
    },
      child:Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            "Splash Screen",
            textAlign: TextAlign.start,
          ),
        ),

        // AppBar
        body:Center(
            // ignore: sized_box_for_whitespace
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




