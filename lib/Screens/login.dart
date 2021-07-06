import 'package:deliverymap/Screens/main_screen.dart';
import 'package:deliverymap/main.dart';
import 'package:deliverymap/widgets/ProgressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register.dart';

class Login extends StatelessWidget {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration:const BoxDecoration(
          color : Colors.white,
        ),
        child:    SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration:const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(40))
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height* 0.4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300.0, left: 40,),
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.montserrat(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),


        const   SizedBox(height: 78),

              Padding(
                padding: const EdgeInsets.all(10.0),
                // ignore: avoid_unnecessary_containers
                child: Container(
                    child: TextFormField(
                      controller: emailTextEditingController,
                      // initialValue: name,
                      style: GoogleFonts.montserrat(color: Colors.black, fontSize: 19),
                      // obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration:const  InputDecoration(
                        prefixIcon: Icon(Icons.mail_outline,
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
                        hintStyle: TextStyle(fontSize: 14, color: Colors.orangeAccent),
                      ),
                    )
                ),
              ),
           const   SizedBox(height: 34),


              // ignore: avoid_unnecessary_containers
              Container(
                  child: TextFormField(
                    controller: passwordTextEditingController,
                    // initialValue: name,
                    style: GoogleFonts.montserrat(color: Colors.black, fontSize: 19),
                    obscureText: true,
                    // keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
                    decoration:const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline,
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
                      hintStyle: TextStyle(fontSize: 14, color: Colors.orangeAccent),
                    ),
                  )
              ),
            const  SizedBox(height: 14),



              GestureDetector(
                onTap: (){

                  if(!emailTextEditingController.text.contains('@'))
                  {
                    displayToastMessage('Invalid Email.', context);
                  }
                  else if(passwordTextEditingController.text.length < 6)
                  {
                    displayToastMessage('Please provide Password', context);
                  }
                  else{
                    loginUser(context);
                  }


                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width* 0.3,
                    decoration:const BoxDecoration(
                      color : Colors.orangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child:const Center(child:  Text('Sign In'))
                ),
              ),
           const   SizedBox(height: 19),

              // ignore: avoid_unnecessary_containers
              Container(
                child:Padding(
                  padding:const  EdgeInsets.only(left: 170),
                  child: Row(
                    children: [
                      const Text('No Account ?'),

                      TextButton(onPressed:(){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    Register()));
                      }, child: const Text('Sign Up'))
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


  void loginUser(BuildContext context) async
  {
    // Displaying the ProgresDialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message: 'Loggin in',);
      }
    );
    
   final User? firebaseUser = (await _firebaseAuth
       .signInWithEmailAndPassword(
     email: emailTextEditingController.text,
       password: passwordTextEditingController.text)
   //displayincg error message if submission is failed
       .catchError((errMsg){
         // Navigator . pop called to close the progress bar in case of an errore
         Navigator.pop(context);
     displayToastMessage('Error:'+ errMsg.toString(), context);
   })).user;

   if (firebaseUser != null) //User Created
       {
// Code checks if the user Exists in the database
     userRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
       if(snap.value != null){

         Navigator.of(context).pushReplacement(
             MaterialPageRoute(
                 builder: (context) =>
                   const  MainScreen()));


         displayToastMessage('Login Successful', context);

       }
       else{
         //signin out the user if the records are nit found.
         Navigator.pop(context);
           _firebaseAuth.signOut();
           displayToastMessage('User Does not exist. Create new account', context);
       }
     });


   }
   else {
     //Error diplay Message
     Navigator.pop(context);
     displayToastMessage('Error, cannot Sign in', context);
   }



 }
}
