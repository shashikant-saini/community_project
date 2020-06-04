import 'package:communityproject/constants.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    this.onPressed,
    this.name,
  });

  final String name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.white,
      onPressed: onPressed,
      hoverColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5.0,
      borderSide: BorderSide(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          name,
          style: kDrawerTS.copyWith(fontSize: 20.0),
        ),
      ),
    );
  }
}

class signinWid extends StatelessWidget {
  const signinWid({this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5.0,
      borderSide: BorderSide(color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("images/g1.png"), height: 60.0),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Sign in with Google',
              style: kDrawerTS.copyWith(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}

class dialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5.0,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) =>
      Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/success.gif',
              height: 150.0,
              width: 150.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                'Your Payment Will be Verified By Admin',
                style: kDrawerTS,
              ),
            ),
          ],
        ),
      );
}

class drawerTile extends StatelessWidget {
  const drawerTile({this.text, this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black45,
          fontSize: 20.0,
        ),
      ),
      leading: Icon(
        icon,
        size: 30.0,
      ),
    );
  }
}
