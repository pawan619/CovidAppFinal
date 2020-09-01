import 'package:covidCare/widgets/Button_c.dart';
import 'package:covidCare/widgets/MyTextFormField_c.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './size_config.dart';
import './ColorClass.dart';
import 'FormValidation.dart';
import 'package:covidCare/services/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({@required this.auth});
  final AuthBase auth;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _myPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  bool _autoValidate = false;
  String get email => this._email;
  String get password => this._password;
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Center(
            // padding: EdgeInsets.all(SizeConfig.heightMultiplier * 5),
            child: Column(
              children: [
                Container(
                  height: SizeConfig.screenHeight / 3,
                  child: Image.asset("assets/images/login.png"),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 1),
                Text("COVID CARE on Mobile",
                    style: GoogleFonts.montserrat(
                        fontSize: SizeConfig.textMultiplier * 3,
                        color: headerColor)),
                Text(
                  "Track your health status in real time",
                  style: GoogleFonts.roboto(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontWeight: FontWeight.w300,
                      color: subHeaderColor),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                Form(
                    key: _formKey,
                    child: Container(
                      width: SizeConfig.widthMultiplier * 80,
                      child: Wrap(
                        runSpacing: SizeConfig.heightMultiplier * 1.5,
                        alignment: WrapAlignment.center,
                        children: [
                          _emailTextField(),
                          _passwordTextField(),
                          _forgotPasswordInkWell(),
                          _loginButton(),
                          Text(
                            "Or Sign In Using",
                            style: GoogleFonts.poppins(
                              color: greyColor,
                              fontSize: SizeConfig.textMultiplier * 2,
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _signInWithGoogleBtn(),
                              _signInWithFacebookBtn(),
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ? ",
                                style: GoogleFonts.poppins(
                                    color: greyColor,
                                    fontSize: SizeConfig.textMultiplier * 2),
                              ),
                              // SizedBox(width: SizeConfig.widthMultiplier * 1),
                              _signUpInkwell()
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

// Email Text Field
  Widget _emailTextField() {
    return MyTextFormField(
      controller: _emailController,
      validator: FormValidation.emailValidation,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email, size: SizeConfig.imageSizeMultiplier * 4.5),
      labelText: "Email",
      hintText: "Enter your email",
      isDense: true,
      // onSaved: (value) => _email = value,
    );
  }

// Show/Hide Password
  void togglePass() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

// Password Text Field
  Widget _passwordTextField() {
    return MyTextFormField(
      controller: _myPassword,
      validator: FormValidation.passwordValidation,
      obscureText: _showPassword,
      isDense: true,
      // focusNode: nodeTwo,
      labelText: "Password",
      hintText: "Enter your password",
      onSaved: (value) => _password = value,
      prefixIcon: Icon(Icons.lock, size: SizeConfig.heightMultiplier * 3),
      suffixIcon: IconButton(
        icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility,
            size: SizeConfig.heightMultiplier * 3),
        onPressed: togglePass,
      ),
    );
  }

// Forgot Password
  Widget _forgotPasswordInkWell() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        alignment: Alignment.bottomRight,
        child: Text(
          "Forgot Password ?",
          style: GoogleFonts.poppins(
              color: greyColor, fontSize: SizeConfig.textMultiplier * 2),
        ),
      ),
    );
  }

  Widget _signUpInkwell() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/UserSignUp'),
      child: Text(
        "SIGN UP",
        style: GoogleFonts.poppins(
            color: loginColor,
            fontSize: SizeConfig.textMultiplier * 2,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      await widget.auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await widget.auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await widget.auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _loginButton() {
    return CustomBTN(
      minWidth: double.infinity,
      onPressed: _validateAndSave,
      text: "LOGIN",
      color: loginColor,
    );
  }

// SignIn with Facebook
  Widget _signInWithFacebookBtn() {
    return MaterialButton(
      onPressed: _signInWithFacebook,
      child: Image.asset("assets/images/fbLogo.png",
          width: SizeConfig.widthMultiplier * 13),
      elevation: 5.0,
      color: Color(0xFF3F51B5),
      shape: CircleBorder(),
    );
  }

// SignIn with Google
  Widget _signInWithGoogleBtn() {
    return MaterialButton(
      onPressed: _signInWithGoogle,
      child: Image.asset("assets/images/Google.png",
          width: SizeConfig.widthMultiplier * 8),
      elevation: 5.0,
      color: Colors.white,
      height: SizeConfig.heightMultiplier * 8,
      shape: CircleBorder(),
    );
  }

  // Validate and save form to Firebase
  void _validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("Form is validated and saved");
    } else {
      setState(() {
        _autoValidate = true;
        print("Form is not validated ");
      });
    }
  }
}

//Login code
/*
import 'package:covidCare/widgets/Button_c.dart';
import 'package:covidCare/widgets/MyTextFormField_c.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './size_config.dart';
import './ColorClass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidCare/services/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({@required this.auth});
  final AuthBase auth;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _emailController = TextEditingController();
  // final _myPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  bool _autoValidate = false;
  String get email => this._email;
  String get password => this._password;
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Center(
            // padding: EdgeInsets.all(SizeConfig.heightMultiplier * 5),
            child: Column(
              children: [
                Container(
                  height: SizeConfig.screenHeight / 3,
                  child: Image.asset("assets/images/login.png"),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 1),
                Text("COVID CARE on Mobile",
                    style: GoogleFonts.montserrat(
                        fontSize: SizeConfig.textMultiplier * 3,
                        color: headerColor)),
                Text(
                  "Track your health status in real time",
                  style: GoogleFonts.roboto(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontWeight: FontWeight.w300,
                      color: subHeaderColor),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                Form(
                    key: _formKey,
                    child: Container(
                      // color: Colors.red,
                      width: SizeConfig.widthMultiplier * 80,
                      // padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Wrap(
                        runSpacing: SizeConfig.heightMultiplier * 1.5,
                        alignment: WrapAlignment.center,
                        children: [
                          _emailTextField(),
                          _passwordTextField(),
                          _forgotPasswordInkWell(),
                          _loginButton(),
                          Text(
                            "Or Sign In Using",
                            style: GoogleFonts.poppins(
                              color: greyColor,
                              fontSize: SizeConfig.textMultiplier * 2,
                            ),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _signInWithGoogleBtn(),
                              _signInWithFacebookBtn(),
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account ? ",
                                style: GoogleFonts.poppins(
                                    color: greyColor,
                                    fontSize: SizeConfig.textMultiplier * 2),
                              ),
                              // SizedBox(width: SizeConfig.widthMultiplier * 1),
                              _signUpInkwell()
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return // Email Text Field
        MyTextFormField(
      // controller: _emailController,
      // validator: FormValidation.emailValidation,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.email, size: SizeConfig.imageSizeMultiplier * 4.5),
      labelText: "Email",
      hintText: "Enter your email",
      // onSaved: (value) => _email = value,
    );
  }

// Show/Hide Password
// void togglePass() {
//   setState(() {
//     _showPassword = !_showPassword;
//   });
// }

// Password Text Field
  Widget _passwordTextField() {
    return MyTextFormField(
      // controller: _myPassword,
      // validator: FormValidation.passwordValidation,
      // obscureText: _showPassword,
      // focusNode: nodeTwo,
      labelText: "Password",
      hintText: "Enter your password",
      // onSaved: (value) => _password = value,
      prefixIcon: Icon(Icons.lock, size: SizeConfig.heightMultiplier * 3),
      // suffixIcon: IconButton(
      //   icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility,
      //       size: SizeConfig.heightMultiplier * 3),
      //   // onPressed: togglePass,
      // ),
    );
  }

// Forgot Password
  Widget _forgotPasswordInkWell() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        alignment: Alignment.bottomRight,
        child: Text(
          "Forgot Password ?",
          style: GoogleFonts.poppins(
              color: greyColor, fontSize: SizeConfig.textMultiplier * 2),
        ),
      ),
    );
  }

  Widget _signUpInkwell() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/UserSignUp'),
      child: Text(
        "SIGN UP",
        style: GoogleFonts.poppins(
            color: loginColor,
            fontSize: SizeConfig.textMultiplier * 2,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      //final authResult = await FirebaseAuth.instance.signInAnonymously();
      await widget.auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      //final authResult = await FirebaseAuth.instance.signInAnonymously();
      await widget.auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      //final authResult = await FirebaseAuth.instance.signInAnonymously();
      await widget.auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _loginButton() {
    return CustomBTN(
      minWidth: double.infinity,
      onPressed: _signInAnonymously,
      text: "LOGIN",
      color: headerColor,
    );
  }

// SignIn with Facebook
  Widget _signInWithFacebookBtn() {
    return MaterialButton(
      onPressed: _signInWithFacebook,
      child: Image.asset("assets/images/fbLogo.png",
          width: SizeConfig.widthMultiplier * 13),
      elevation: 5.0,
      color: Color(0xFF3B5998),
      shape: CircleBorder(),
    );
  }

// SignIn with Google
  Widget _signInWithGoogleBtn() {
    return MaterialButton(
      onPressed: _signInWithGoogle,
      child: Image.asset("assets/images/Google.png",
          width: SizeConfig.widthMultiplier * 8),
      elevation: 5.0,
      color: Colors.white,
      height: SizeConfig.heightMultiplier * 8,
      shape: CircleBorder(),
    );
  }
}
 */
