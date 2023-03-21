import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/main.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';
import 'package:login_firebase_flutter/user/ProfileData.dart';
import '../screens/HomePage.dart';
import '../screens/changePassword.dart';
import '../screens/login.dart';
import '../screens/SignUp.dart';
import '../user/user_screen.dart';
class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=> const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context)=> const SignupScreen());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=> const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=> const HomeScreen());
      case RoutesName.change:
        return MaterialPageRoute(builder: (BuildContext context)=>  const ChangePassword());
      case RoutesName.dashboard:
        return MaterialPageRoute(builder: (BuildContext context)=> const UserScreen());

      case RoutesName.profile:
         return MaterialPageRoute(builder: (BuildContext context)=> const UserProfile());
       default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text(" no routes defined"),
            ),
          );
        });
      }
  }
}