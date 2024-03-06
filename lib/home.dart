// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/screens/email_auth/login_screen.dart';
import 'package:firebase_series/screens/phone_auth/sign_in_with_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInWithPhone()));
  }

  void saveUser() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    nameController.clear();
    emailController.clear();

    if (name != "" && email != "") {
      Map<String, dynamic> userData = {
        "name": name,
        "email": email,
      };
      FirebaseFirestore.instance.collection("users").add(userData);
      print("user created");
    } else {
      print("Please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text("Home"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: IconButton(
                onPressed: () {
                  logOut();
                },
                icon: Icon(
                  Icons.logout,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Name"),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: "Email Address"),
                ),
                SizedBox(
                  height: 40,
                ),
                CupertinoButton(
                  child: Text("Save"),
                  onPressed: () {
                    saveUser();
                  },
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 40,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> userMap =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              return ListTile(
                                title: Text(userMap["name"]),
                                subtitle: Text(userMap["email"]),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text("No data!");
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
