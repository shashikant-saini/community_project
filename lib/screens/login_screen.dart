import 'package:communityproject/constants.dart';
import 'package:communityproject/screens/Drawer_Screen.dart';
import 'package:flutter/material.dart';
import 'package:communityproject/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String email;
  String pass;

  void getUser() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser != null) {
      Navigator.pushNamed(context, 'screen');
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/p1.jpeg'), fit: BoxFit.cover),
        ),
        child: ModalProgressHUD(
          inAsyncCall: spinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    style: kDrawerTS.copyWith(fontSize: 15.0),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kInputDecor),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    style: kDrawerTS.copyWith(fontSize: 15.0),
                    onChanged: (value) {
                      pass = value;
                    },
                    decoration:
                        kInputDecor.copyWith(hintText: 'Enter Password')),
                SizedBox(
                  height: 24.0,
                ),
                NewWidget(
                  name: 'Login',
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: pass);
                      if (user != null) {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (BuildContext context) => DrawerPage()));
                      }
                      setState(() {
                        spinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
