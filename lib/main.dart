import 'package:deliverymap/DataHandler/app_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/login.dart';
import 'Screens/main_screen.dart';
import 'Screens/register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//Creating the firebase Database Reference
DatabaseReference userRef = FirebaseDatabase.
instance.reference().child('User');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //initializing the provider package to be accessible for the whole project
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Delivery App',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: Login(),
      ),
    );
  }
}


