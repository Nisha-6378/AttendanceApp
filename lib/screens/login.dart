
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidation {
   TextEditingController emailController= TextEditingController();
   TextEditingController passwordController= TextEditingController();
  final formGlobalKey = GlobalKey <FormState>();
  // final collectionReference= FirebaseFirestore.instance.collection('Users').doc(AttandenceApp.user?.uid );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      return false;
    },
      child:MaterialApp(
        theme: ThemeData(backgroundColor: Colors.pink),

        home: Scaffold(

          appBar: AppBar(title: const Text(" Login Page")),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email:'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if(isEmailValidation(email!)){
                         return null ;
                      }
                      else{
                        return " Please enter valid email";
                      }
                    }


                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password:'),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {

                    },
                    maxLength: 8,
                    obscureText: true,
                    validator: (password) {
                      if (ispasswordValid(password!)) {
                        return null;
                      }
                      return " enter valid password";
                    },

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed:  (){
                            },
                          child: const Text(" forgot Password",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                          ),))
                    ],

                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(

                    style: TextButton.styleFrom(
                        primary: Colors.green
                    ),
                    onPressed: () {
                      if(formGlobalKey.currentState!.validate()){
                        formGlobalKey.currentState!.save();
                        LoginUser();

                        // logindata.setBool('login', false);
                        // logindata.setString('username', emailController.text);
                      }

                    },
                    child: const Text('Login ',
                        style: TextStyle(color: Colors.white, fontSize: 20)
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" Don't have an account ?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context,RoutesName.signup);
                        },
                      child:Text("Register ", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                      ),
                      ],
                  ),

                ],

              ),

            ),
          ),
        )
    )
    );
  }




   Future LoginUser() async {
      FirebaseAuth auth = FirebaseAuth.instance;
        try {
       await auth.signInWithEmailAndPassword(
           email: emailController.text, password: passwordController.text).then((
           value) =>
       {
           print("Sucess ${auth}"),
           Fluttertoast.showToast(msg: "Login Sucessfull "),
         Navigator.pushNamed(context, RoutesName.dashboard)
       });

     }
     on FirebaseAuthException catch(e){
       if(e.code==" user-not-found"){
         print(" Not User Fount");
         Fluttertoast.showToast(msg: "User Not Found..");

       }
       else if(e.code=='wrong-password'){
         Fluttertoast.showToast(msg: "Wrong Password");
      }
       else{
           Fluttertoast.showToast(msg: "Account is not Found. Please do sinUp");
       }
     }
   }






}
  mixin InputValidation{
    bool ispasswordValid(String password)=> password.length==8;
    bool isEmailValidation(String email) {
      return  RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    }
}
