import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_firebase_flutter/config/config.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  get user => null;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with  isInputValidation {
  bool isloading =false;
   final databadeRef=FirebaseDatabase.instance.ref("Users");
  final formGlobalKey = GlobalKey <FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
      return false;
    },
      child:MaterialApp(
        theme: ThemeData(backgroundColor: Colors.pink),

        home: Scaffold(

          appBar: AppBar(title: Text(" SignUp  Page")),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Name:'),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {

                      },
                      validator: (name) {
                        if (isNameValidation(name!)) {
                          return null;
                        }
                        else {
                          return " Please enter  Carrect Name";
                        }
                      }


                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email:'),
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (value) {

                      },
                      validator: (email) {
                        if (isEmailValidation(email!)) {
                          return null;
                        }
                        else {
                          return " Please enter valid email";
                        }
                      }


                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password:'),
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
                  const SizedBox(height: 30),

                  ElevatedButton(

                    style: TextButton.styleFrom(
                        primary: Colors.green
                    ),
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                        signUpUser();
                        Navigator.pushNamed(context, RoutesName.login);


                           }

                      },

                    child: const Text('SignUp ',
                        style: TextStyle(color: Colors.white, fontSize: 20)
                    ),
                  )

                ],

              ),

            ),
          ),
        )
    )
    );
  }

  Future signUpUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;

    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text).then((
          value) =>
      {
        FirebaseFirestore.instance.collection("Users").doc(value.user?.uid).set(
            {
              'name': nameController.text,
              'email': emailController.text,
              'password': passwordController.text,


            }).then((value) =>
        {
          print("success"),

          Fluttertoast.showToast(msg: "Registration  SuccessFull..."),
        })
      });
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'email-already- in-used') {
        print(" email already exit ");
        Fluttertoast.showToast(msg: "Email is already Exit");
      }
      else{
         Fluttertoast.showToast(msg: " name  and Passwords  are Already  exit");
      }
    }
  }

}

mixin isInputValidation {
  bool isNameValidation(String name){
    return RegExp(
        r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)").hasMatch(name);

  }

  bool ispasswordValid(String password) => password.length == 8;

  bool isEmailValidation(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}


