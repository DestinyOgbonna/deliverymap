import 'package:deliverymap/main.dart';
import 'package:deliverymap/widgets/ProgressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class Register extends StatelessWidget {
  // Controllers for the TextFields that will submit values to database
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // ignore: file_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration:const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration:const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(40))),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 300.0,
                      left: 40,
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.montserrat(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            const  SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                // ignore: avoid_unnecessary_containers
                child: Container(
                    child: TextFormField(
                  //controllers for each text
                  controller: nameTextEditingController,
                  // initialValue: name,
                  style:
                      GoogleFonts.montserrat(color: Colors.black, fontSize: 19),
                  // obscureText: true,
                  // keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
                  decoration:const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blueGrey,
                    ),
                    // border type enabled and border styling
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent),
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    ),

                    // focusedBorder: OutlineInputBorder( for the outline border

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent),
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Name',
                    hintStyle:
                        TextStyle(fontSize: 14, color: Colors.orangeAccent),
                  ),
                )),
              ),
            const  SizedBox(height: 14),
              // ignore: avoid_unnecessary_containers
              Container(
                  child: TextFormField(
                controller: emailTextEditingController,
                // initialValue: name,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 19),
                // obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration:const InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.blueGrey,
                  ),
                  // border type enabled and border styling
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),

                  // focusedBorder: OutlineInputBorder( for the outline border

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'email',
                  hintStyle:
                      TextStyle(fontSize: 14, color: Colors.orangeAccent),
                ),
              )),
             const SizedBox(height: 14),
              // ignore: avoid_unnecessary_containers
              Container(
                  child: TextFormField(
                controller: phoneTextEditingController,
                // initialValue: name,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 19),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueGrey,
                  ),
                  // border type enabled and border styling
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),

                  // focusedBorder: OutlineInputBorder( for the outline border

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Phone',
                  hintStyle:
                      TextStyle(fontSize: 14, color: Colors.orangeAccent),
                ),
              )),
            const  SizedBox(height: 14),


              // ignore: avoid_unnecessary_containers
              Container(
                  child: TextFormField(
                controller: passwordTextEditingController,
                // initialValue: name,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 19),
                obscureText: true,
                // keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
                decoration:const InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.blueGrey,
                  ),
                  // border type enabled and border styling
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),

                  // focusedBorder: OutlineInputBorder( for the outline border

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Password',
                  hintStyle:
                      TextStyle(fontSize: 14, color: Colors.orangeAccent),
                ),
              )),
            const  SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  //=========== Form Validation============
                  // name validation, name characters must be 4
                  if (nameTextEditingController.text.length < 3) {
                    displayToastMessage(
                        'Name Must be atleast 3 characters.', context);
                  } else if (!emailTextEditingController.text.contains('@')) {
                    displayToastMessage('Invalid Email.', context);
                  } else if (phoneTextEditingController.text.isEmpty) {
                    displayToastMessage('Enter Phone Number.', context);
                  } else if (passwordTextEditingController.text.length < 6) {
                    displayToastMessage(
                        'Password Must be Atleast 6 characters.', context);
                  } else {
                    //reguster user
                    registerNewUser(context);
                  }
                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: const Center(child: Text('Sign Up'))),
              ),
              const SizedBox(height: 19),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Padding(
                  padding:const EdgeInsets.only(left: 170),
                  child: Row(
                    children: [
                      const Text('Have an account ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child:const Text('Sign in'))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    // Displaying the ProgresDialog
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: 'Registering, Please wait',
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            //displayincg error message if submission is failed
            .catchError((errMsg) {
      // Navigator . pop called to close the progress bar in case of an errors
      Navigator.pop(context);
      displayToastMessage('Error:' + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //User Created
    {
// saving the new  user details
      Map userDataMap = {
        'name': nameTextEditingController.text.trim(),
        'email': emailTextEditingController.text.trim(),
        'phone': phoneTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage('Account Created', context);
      //Navigating to the login page
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } else {
      //Error diplay Message
      Navigator.pop(context);
      displayToastMessage('User not Created', context);
    }
  }
}

// Flutter Toast function to display error Messages

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
