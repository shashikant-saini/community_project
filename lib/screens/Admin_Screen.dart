import 'package:communityproject/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
import 'package:communityproject/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';


class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<UpiResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp> apps;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String em;
  String em1;

  @override
  void initState() {
    super.initState();
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
      });
    });
    getcurrentUser();
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<UpiResponse> initiateTransaction(String app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: 'rockingrahulsaini-2@okicici',
      receiverName: 'Shashikant Saini',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps.length == 0)
      return Center(child: Text("No apps found to handle transaction."));
    else
      return Center(
        child: Wrap(
          children: apps.map<Widget>((UpiApp app) {
            return GestureDetector(
              onTap: () {
                _transaction = initiateTransaction(app.app);
                setState(() {});
              },
              child: Container(
                height: 100,
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Image.memory(
                          app.icon,
                          height: 55,
                          width: 55,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
  }

  void getcurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        setState(() {
          em = loggedInUser.email;
          em1 = loggedInUser.email[0].toUpperCase();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawerEdgeDragWidth: 0,
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(
                '$em',
                style: kDrawerTS,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Center(
                  child: Text(
                    '$em1',
                    style: kDrawerTS.copyWith(
                        fontWeight: FontWeight.w800, fontSize: 40.0),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/p1.jpeg'),
                ),
              ),
            ),
            GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'register');
                },
                child: drawerTile(text: 'Register User',icon: Icons.add,)
            ),
            GestureDetector(
                onTap: () async{
                  _auth.signOut();
                  signOutGoogle();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: drawerTile(text: 'Log Out',icon: Icons.power_settings_new,)
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 40.0, right: 20.0, left: 20.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 35.0,
                  icon: Icon(Icons.short_text),
                  onPressed: () {
                    _drawerKey.currentState.openDrawer();
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: Icon(Icons.share),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 180.0,
            child: Center(
              child: Text(
                'You have payment Due of Rs 250',
                style: kDrawerTS.copyWith(fontSize: 22.0),
              ),
            ),
            decoration: kBoxDecor,
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 50.0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Paid via Cash',
                      style: kDrawerTS.copyWith(fontSize: 18.0, letterSpacing: 1.5),
                    ),
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(
                        Icons.check,
                        color: Color(0xFFFFFFFF),
                      ),
                      onPressed: (){
                        DialogHelper.exit(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            decoration: kBoxDecor
          ),
          SizedBox(height: 30.0),
          Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Pay via UPI',
                  style: kDrawerTS.copyWith(fontSize: 18.0,letterSpacing: 1.5),
                ),
              ),
            ),
            decoration: kBoxDecor,
          ),
          SizedBox(height: 20.0),
          displayUpiApps(),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: FutureBuilder(
              future: _transaction,
              builder:
                  (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('An Unknown error has occured'));
                  }
                  UpiResponse _upiResponse;
                  _upiResponse = snapshot.data;
                  if (_upiResponse.error != null) {
                    String text = '';
                    switch (snapshot.data.error) {
                      case UpiError.APP_NOT_INSTALLED:
                        text = "Requested app not installed on device";
                        break;
                      case UpiError.INVALID_PARAMETERS:
                        text = "Requested app cannot handle the transaction";
                        break;
                      case UpiError.NULL_RESPONSE:
                        text = "requested app didn't returned any response";
                        break;
                      case UpiError.USER_CANCELLED:
                        text = "You cancelled the transaction";
                        break;
                    }
                    return Center(
                      child: Text(text),
                    );
                  }
                  String txnId = _upiResponse.transactionId;
                  //String resCode = _upiResponse.responseCode;
                  //String txnRef = _upiResponse.transactionRefId;
                  //String approvalRef = _upiResponse.approvalRefNo;
                  String status = _upiResponse.status;
                  switch (status) {
                    case UpiPaymentStatus.SUCCESS:
                      print('Transaction Successful');
                      break;
                    case UpiPaymentStatus.SUBMITTED:
                      print('Transaction Submitted');
                      break;
                    case UpiPaymentStatus.FAILURE:
                      print('Transaction Failed');
                      break;
                    default:
                      print('Received an Unknown transaction status');
                  }
                  /*return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Transaction Id: $txnId\n'),
                      Text('Response Code: $resCode\n'),
                      Text('Reference Id: $txnRef\n'),
                      Text('Status: $status\n'),
                      Text('Approval No: $approvalRef'),
                    ],
                  );*/
                  switch (status) {
                    case UpiPaymentStatus.SUCCESS:
                      print('Transaction Successful');
                      break;
                    case UpiPaymentStatus.SUBMITTED:
                      print('Transaction Submitted');
                      break;
                    case UpiPaymentStatus.FAILURE:
                      print('Transaction Failed');
                      break;
                    default:
                      print('Received an Unknown transaction status');
                  }
                  if (UpiPaymentStatus.SUCCESS == status) {
                    controller = AnimationController(
                      duration: Duration(seconds: 7),
                      vsync: this,
                    );
                    animation = Tween(
                      begin: 5.0,
                      end: 0.0,
                    ).animate(controller);
                    controller.forward();
                    return FadeTransition(
                      opacity: animation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/success.gif',
                            height: 70.0,
                            width: 70.0,
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            'Payment Successful',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            'ID: $txnId',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    controller = AnimationController(
                      duration: Duration(seconds: 7),
                      vsync: this,
                    );
                    animation = Tween(
                      begin: 5.0,
                      end: 0.0,
                    ).animate(controller);
                    controller.forward();
                    return FadeTransition(
                      opacity: animation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/Error.gif',
                            height: 70.0,
                            width: 70.0,
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            'Payment Failed!',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else
                  return Text(' ');
              },
            ),
          ),
        ],
      ),
    );
  }
}

