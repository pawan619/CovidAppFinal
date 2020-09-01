import 'dart:ffi';
import 'package:covidCare/services/auth.dart';
import 'package:covidCare/LoginPage.dart';
import 'package:covidCare/home_page.dart';
import 'package:covidCare/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginPage();
            }
            return Provider<Database>(
              builder: (_) => FirestoreDatabase(),
              child: HomePage(),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
