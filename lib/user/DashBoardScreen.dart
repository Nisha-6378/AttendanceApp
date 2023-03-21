import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();

}
class _DashBoardState extends State<DashBoard> {
  static const String KEYNAME= "date";
  Position? currentPosition;
  String? currntAddress;
  DateTime? currntTime;
  String? todayDate;
  static bool isPunchIn= false;
  SharedPreferences ? pref;
  final prefs =  SharedPreferences.getInstance();
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat("dd MMMM yyyy");
  final collectionReference= FirebaseFirestore.instance.collection('Users').doc(AttandenceApp.user?.uid );
  /// Variable for Punch Out
  DateTime? punchOutTime;
  static String? punchOutDate;
  /// for storing Punch In Time in sharedPrefrencess
  @override
  void initState() {
    if(mounted) {
      _getServerData();
    }
       super.initState();
  }
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  /// fun for Location Handled
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: "Location Services are Not enable. Please Enable..");
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location Permission are denid");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: 'Location Permission are peramental Denied, You can not request ferther..');
      return false;
    }
    return true;
  }

  /// Function for get current Position
  Future <void> _getCurrentPossition() async {
    final haspermission = await handleLocationPermission();
    if (!haspermission) return;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) =>
    {
      setState(() => currentPosition = position),
      getAddressOfLatLang(currentPosition)
    }).catchError((e) {
      debugPrint(e);
    });
  }

  /// Function for get current Address
  Future<void> getAddressOfLatLang(Position? position) async {
    await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude).then((
        List<Placemark> placemark) {
      Placemark place = placemark[0];
      setState(() {
        currntAddress =
        '${place.street}, ${place.subAdministrativeArea}, ${place.subLocality}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }


  /// fun for PunchIn Time and Date into Firebase Database
  ///
  ///

  addServerTime() {
    User? user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('Date $currentDate').doc(user?.uid).set({
      'PunchInTime': FieldValue.serverTimestamp(),
      'PunchInDate': DateFormat('yyyy-MM-dd').format(DateTime.now())
    });
  }
  /// fun for get The data from  Firebase Database
  Future<void> _getServerData() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid).collection('Date $currentDate').doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        currntTime =  userData.data()?["PunchInTime"]?.toDate();
        todayDate = userData.data()!['PunchInDate'];
        DateTime tempDate = DateFormat("yyyy-MM-dd").parse(["PunchInTime"] as String);

        // todayDate = prefs.setString(KEYNAME, todayDate!) as String? ;
        print("Date-only $currntTime, ${todayDate} ${tempDate}");

      });
    });
  }
  ///  All function for SingOut
  addServerTimePunch() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection('Date $currentDate').doc().set({
      'PunchOut': FieldValue.serverTimestamp(),
      'PunchOutDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });
  }
  Future<void> _getServerDataForPunchOut() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid).collection('Date $currentDate').doc(user.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        punchOutTime = userData.data()?['ServerDate'].toDate();
        punchOutDate= userData.data()!['date'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !isPunchIn? ElevatedButton(onPressed: (currentDate !=todayDate) ||(todayDate==null && punchOutDate==null) ?() async {
                      // punchInDay();
                      setState(() {
                      _getCurrentPossition();
                      if( (25.252312 <= currentPosition!.latitude  &&  currentPosition!.latitude <= 27.252312) && (71.9983417 <= currentPosition!.longitude && currentPosition!.longitude <= 73.7829879 ))
                      {
                        isPunchIn=true;
                      }
                      else
                      {
                        Fluttertoast.showToast(msg: "Punch In is not allows");
                      }
                      addServerTime();
                      FutureBuilder(
                          future: _getServerData(),
                          builder: (context, snapshot) {
                            return Column(
                              children: [
                                Text('${currntTime.toString()}'),
                                Text('Longitude: ${currentPosition
                                    ?.longitude ?? ""}'),
                                Text('Latitude: ${currentPosition
                                    ?.latitude ??
                                    ""} '),
                                Text('Address: ${currntAddress ?? ""}'),
                                Text('TodayDate: ${todayDate!} '),
                              ],
                            );
                          });
                      });
                    }: null,
                        child: const Text('PunchIn' )) :
                    ElevatedButton(onPressed: (){
                      setState(() {
                      isPunchIn =false;
                      print('Punch Out $isPunchIn');
                      Fluttertoast.showToast(msg: "Punch Out $isPunchIn");
                      addServerTimePunch();
                      });

                            },child: const Text("Punch Out")),
                    Text('PunchIn Time: ${currntTime.toString()}'),
                    Text('Longitude: ${currentPosition?.longitude ?? ""}'),
                    Text('Latitude: ${currentPosition?.latitude ?? ""} '),
                    Text('Address: ${currntAddress ?? ""}'),
                    Text('TodayDate: ${todayDate?? ""} '),
                  ],
                )
            )
        )
    );
  }
}

