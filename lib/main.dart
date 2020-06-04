import 'package:communityproject/screens/Drawer_Screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      routes: {
        'login': (context) => LoginScreen(),
        'register': (context) => RegistrationScreen(),
        'screen': (context) => DrawerPage(),
      },
    );
  }
}
