import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/add_new_weight.dart';
import 'package:task/screens/anonymous_signin.dart';
import 'package:task/screens/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: {
        "/register": (context) => AnonymousSignIn(),
        "/home": (context)=>MyHomePage(),
        "/addNewPage": (context) => AddWeight(),
      },
      home:  AnonymousSignIn(),
    );
  }
}


