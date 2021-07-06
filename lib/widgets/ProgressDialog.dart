import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressDialog extends StatelessWidget
{
  // a message string was created to store all the message values
  String message;
  // ignore: file_names
 ProgressDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor:
              AlwaysStoppedAnimation <Color>(Colors.black54),),
              SizedBox(width: 26.0,),
            Text(
              message,
              style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
            )
            ],
          ),
        ) ,
      ),
    );
  }
}

