import 'dart:async';
import 'package:covidCare/landingPage.dart';
import 'package:covidCare/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidCare/services/auth.dart';
import 'package:provider/provider.dart';
import 'ColorClass.dart';
import 'LoginPage.dart';
import 'UserSignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      builder: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/UserSignUp': (context) => UserSignUp(),
        },
      ),
    );
  }
}
/*=> runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/UserSignUp': (context) => UserSignUp(),
      },
    ));*/

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                "assets/images/covidLogo.png",
                width: SizeConfig.widthMultiplier * 30,
              ),
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 2),
            RichText(
              text: TextSpan(
                style: GoogleFonts.montserratAlternates(
                    color: primaryColor,
                    fontSize: SizeConfig.textMultiplier * 3),
                children: <TextSpan>[
                  TextSpan(text: "COVID\t"),
                  TextSpan(
                    text: "CARE",
                    style: TextStyle(color: secondaryColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LandingPage()));
  }
}
