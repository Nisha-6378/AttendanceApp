import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_firebase_flutter/routes/routes_name.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with changePassword{
  final formGlobalKey = GlobalKey <FormState>();
    TextEditingController passwordController =  TextEditingController();
    TextEditingController repasswordController = TextEditingController();

  /// Update data into firebase in flutter
  Future<void> upDate(Map data) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Users').doc(user!.uid).update(data as Map<Object, Object?>);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(title: const Text("Change Password" ),
           automaticallyImplyLeading: false,
     backgroundColor: Colors.blue,),

      body: Padding(
         padding: const EdgeInsets.all(20.0),
        child: Form(
          key:  formGlobalKey ,
         child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
             TextFormField(
             controller: passwordController,
            
             decoration: const InputDecoration(labelText: 'Enter Password:'),
             keyboardType: TextInputType.emailAddress,
             onFieldSubmitted: (value) {
                passwordController.text=value;
             },
             validator: (password) {
               if(isPasswordValidation(password!)){
                 return null ;
               }
                           
               else{
                 return "password length Should be 8 Character ";
               }
             }
             ),
               TextFormField(
                   controller: repasswordController,
                   decoration: const InputDecoration(labelText: 'Confirm  Password:'),
                   keyboardType: TextInputType.emailAddress,
                   onFieldSubmitted: (value) {
                       
                   },
                  validator: (password) {
                     if(ConfirmPasswordValidation(password!)){
                       return null ;
                     }
                     else if(password!=passwordController.text){
                        return " Password  doesn't match ";
                     }
                   
                     else{
                       return "  password length Should be 8 Character ";
                     }
                   }
               ),
                const SizedBox(height: 30,),
                ElevatedButton(onPressed: () async{
                 if(formGlobalKey.currentState!.validate()){
                   formGlobalKey.currentState!.save();
                   ReChangePassword();
                 }

                },
                   child: const Text("Save Password")
               ),
             ],
         ),
        ),
      ),

    );
  }
  final currentUser= FirebaseAuth.instance.currentUser;
  ReChangePassword() async{
    try{
        await  currentUser!.updatePassword(passwordController.text);

        Map<String,String> dataToupDated={
          'password':  passwordController.text,
        };
        /// Add The data to the Database
        User? user = await FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance.collection('Users').doc(user?.uid).update(dataToupDated);
        Fluttertoast.showToast(msg: "Password Sucessfully Change");
        Navigator.pushNamed(context,RoutesName.dashboard);
    }
    // ignore: empty_catches
    catch(e){

    }

  }
}

mixin changePassword{
bool isPasswordValidation(String password) {
      return password.length==8;
 }
  // ignore: non_constant_identifier_names
  bool ConfirmPasswordValidation(String repassword) {
      return repassword.length==8;
   }
 }
