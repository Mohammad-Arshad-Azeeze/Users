import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class Home extends StatelessWidget {
  const Home();

  Future<void> _signOut(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Text("Logged Successfully "),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _signOut(context),
            child: Text('Sign Out')),
        ],
      )),
    );
  }
}
