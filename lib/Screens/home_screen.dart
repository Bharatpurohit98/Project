import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/Screens/Login/number.dart';
import 'package:sample/Screens/add_Sale.dart';
import 'package:sample/Screens/purchase.dart';

// ignore: must_be_immutable
class Homescreen extends StatefulWidget {
  static const routename = '/home-screen';

  String? businessName;
  Homescreen({this.businessName});

  @override
  _SecondState createState() => _SecondState(businessName);
}

class _SecondState extends State<Homescreen> {
  final _auth = FirebaseAuth.instance;

  String? businessName;
  _SecondState(this.businessName);
  @override
  Widget build(BuildContext context) {
    this.context ;
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Items'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(''),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          //centerTitle: true,
          title: Text(
            businessName!,
            style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async {
                await _auth.signOut();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton.icon(onPressed: () => {}, icon: Icon(Icons.add,color: Colors.black,), label: Text('Press')),
                ElevatedButton(
                    onPressed: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Sale()))
                        },
                    child: Text("SALE"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(140, 45),
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 4,
                    )),
                /* TextButton(
                    child: Text(
                      "SALE",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue)))),
                    onPressed: null),*/
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(45, 45),
                    shape: CircleBorder(),
                    primary: Colors.blue[50],
                    side: BorderSide(color: Colors.blue),
                    elevation: 4,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.blue[600],
                    size: 30,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 500,
                            color: Colors.white60,
                            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          );
                        });
                  },
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Purchase()))
                  },
                  child: Text("PURCHASES"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    minimumSize: Size(140, 45),
                    elevation: 4,
                  ),
                ),
                /* TextButton(
                    child: Text(
                      "PURCHASE",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)))),
                    onPressed: null) */
              ],
            ),
          ),
        ));
  }
}
