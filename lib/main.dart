// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/home.dart';
import 'package:firebase_series/screens/phone_auth/sign_in_with_phone.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //storing instance in a variable to minimize code and simply writing variable instead of instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for fetching data using firebase database
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("uFnzU8mugY50jogITkNU")
  //     .get();
  // print(snapshot.data().toString());

  //for adding data in firebase database
  // Map<String, dynamic> newUserData = {
  //   "name": "Slantcode",
  //   "email": "slantcode@gmail.com"
  // };
  // await _firestore
  //     .collection("users")
  //     .doc("your-id-here")
  //     .update({"email": "slantcode2@gmail.com"});
  // print("New user updated");

  //for deleting data in firebase database
  await _firestore.collection("users").doc("your-id-here").delete();
  print("user deleted");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //if the user is logged in then we show home page
      // home: (FirebaseAuth.instance.currentUser != null)
      //     ? HomeScreen()
      //     : SignInWithPhone(),
      home: HomeScreen(),
    );
  }
}
