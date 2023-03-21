import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/user/ProfileData.dart';
import 'DashBoardScreen.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // ignore: non_constant_identifier_names
  int index_selection=0;
  static final List<Widget> _widgetoption = <Widget>[
   const DashBoard(),
   const UserProfile()
   
  ];
  void onItemTap(int index){
    setState(() {
      index_selection=index;
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
        backgroundColor: Colors.pink,
         title: const Text(" Welcom to The Home Screen "),automaticallyImplyLeading: false,

          ),


      body: _widgetoption.elementAt(index_selection),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink,
        items: const<BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
          label: 'DashBoard'),
          
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: " My Profile"
          )
          
        ],
        currentIndex: index_selection,
          selectedItemColor: Colors.green[800],
        onTap: onItemTap,
      ),
    )
    );
  }
  

}


