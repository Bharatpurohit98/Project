import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sample/Screens/Login/number.dart';

import 'globalvariables.dart';

class GlobalFunctions {
  void storedata(context) {
    // ignore: non_constant_identifier_names
    String contact_Number = GlobalVariables().storeNumber;
    // ignore: non_constant_identifier_names
    String business_Name = GlobalVariables().bussNameInput;
    Map<String, String> contacts = {
      'number': contact_Number,
      'business_Name': business_Name
    };
    try {
      GlobalVariables().ref!.push().set(contacts);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
  void inputverifier(context) {
    if (contact == " ") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter your phone Number",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold),)));
    } else if (contact.length < 10) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter a valid phone number",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold),)));
    }
  }
}
