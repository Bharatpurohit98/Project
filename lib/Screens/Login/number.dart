import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:sample/Screens/home_screen.dart';

import 'package:sample/Screens/Login/details.dart';
import 'package:sample/Screens/Login/globalfunctions.dart';
import 'package:sample/Screens/Login/globalvariables.dart';
//import 'package:sample/Screens/home_screen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final phoneController = TextEditingController();
final otpController = TextEditingController();
final contact = phoneController.text;
final phoneNumber = "+91" + contact;

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        // GlobalVariables().storeNumber = phoneController.text;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BusinessName()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          maxLength: 10,
          decoration: InputDecoration(
            prefix: Text("+91"),
            hintText: "Phone Number",
            prefixIcon: Icon(
              Icons.phone_android,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () {
              GlobalFunctions().inputverifier(context);
              setState(() {
                showLoading = true;
              });
              _auth.verifyPhoneNumber(
                phoneNumber: phoneNumber,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                },
                verificationFailed: (phoneVerificationFailed) async {
                  var verificationFailed;
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(verificationFailed.message)));
                  setState(() {
                    showLoading = false;
                  });
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            },
            child: Text(
              "Send Otp",
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            )),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: "Enter Otp",
            prefixIcon: Icon(
              Icons.account_circle,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId!,
                      smsCode: otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            child: Text(
              "Verify",
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            )),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        key: _scaffoldkey,
        child: Scaffold(
            body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        )));
  }
}

// class Storedata extends _LoginScreenState {}
