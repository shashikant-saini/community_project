import 'package:flutter/material.dart';
import 'package:communityproject/widgets.dart';
import 'package:communityproject/constants.dart';
import 'Drawer_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String email;
  String pass;
  bool spinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      backgroundColor: Colors.transparent,
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
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                      Container(
                        child: Image.asset('images/logo.png'),
                        height: 65.0,
                      ),
                    TypewriterAnimatedTextKit(
                      text: ['Social Pay'],
                      textStyle: TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
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
