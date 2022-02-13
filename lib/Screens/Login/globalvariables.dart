import 'package:firebase_database/firebase_database.dart';

class GlobalVariables {
  var storeNumber;
  var bussNameInput;
  DatabaseReference? ref =
      FirebaseDatabase.instance.ref().child('User Details');
}
 