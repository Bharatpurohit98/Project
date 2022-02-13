// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/Screens/Login/globalfunctions.dart';
import 'package:sample/Screens/Login/globalvariables.dart';

// import 'package:sample/main.dart';
import 'package:sample/Screens/home_screen.dart';

import 'number.dart';
//import 'package:sample/Screens/global_functions.dart';
// import 'package:sample/Screens/Login/number.dart';

class BusinessName extends StatefulWidget {
  const BusinessName({Key? key}) : super(key: key);

  @override
  _BusinessNameState createState() => _BusinessNameState();
}

 

final textController = TextEditingController();

String? value;

class _BusinessNameState extends State<BusinessName> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Enter Business Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(),
            TextField(
              controller: textController,
              decoration: InputDecoration(hintText: "Business Name"),
              onChanged: (text) {
                value = text;
              },
            ),
            ElevatedButton(
              onPressed: () => {
                GlobalVariables().bussNameInput = textController.text,
                print(GlobalVariables().bussNameInput),
                GlobalFunctions().storedata(context),
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Homescreen(
                              businessName: value,
                            )))
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => Homescreen(businessName: value)))
              },
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(140, 45),
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                elevation: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
