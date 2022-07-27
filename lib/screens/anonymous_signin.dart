import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/helper/shared_preferences.dart';
import 'package:task/screens/home_page.dart';

class AnonymousSignIn extends StatefulWidget {
  const AnonymousSignIn({Key? key}) : super(key: key);

  @override
  State<AnonymousSignIn> createState() => _AnonymousSignInState();
}

class _AnonymousSignInState extends State<AnonymousSignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black26,
          child: Center(
            child: ElevatedButton(
              onPressed: () async{
                UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
                SharedPreferencesHelper.setUserId(userCredential.user!.uid);
                FirebaseAuth.instance
                    .authStateChanges()
                    .listen((User? user) async{
                  if (user == null) {
                    userCredential = await FirebaseAuth.instance.signInAnonymously();
                  } else {
                    print("signed in");
                   Navigator.pushReplacementNamed(context, "/home");
                  }
                });
              },
              child: Text(
                "Anonymous signIn",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
