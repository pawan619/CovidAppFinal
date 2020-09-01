import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './size_config.dart';
import './ColorClass.dart';
import './widgets/Button_c.dart';
import './widgets/MyTextFormField_c.dart';
import './FormValidation.dart';
import 'package:covidCare/services/auth.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final Auth _auth = Auth();

  String _firstName;
  String _lastName;
  String _emailID;
  String _phoneNumber;
  String _password;
  bool _autoValidate = false;
  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get emailID => this._emailID;
  String get phoneNumber => this._phoneNumber;
  String get password => this._password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: _signUpImage(),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.heightMultiplier * 4),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Wrap(
                    runSpacing: SizeConfig.heightMultiplier * 2,
                    children: [
                      _signUpTitle(),
                      _buildFirstName(),
                      _buildLastName(),
                      _buildEmail(),
                      _buildPhoneNumber(),
                      _buildPassword(),
                      _signUpButton(),
                      SizedBox(height: SizeConfig.heightMultiplier * 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ? ",
                            style: GoogleFonts.poppins(
                                color: greyColor,
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                          SizedBox(width: SizeConfig.heightMultiplier * 1),
                          InkWell(
                            onTap: () => Navigator.pop(context, '/LoginPage'),
                            child: Text(
                              "LOGIN",
                              style: GoogleFonts.poppins(
                                  color: signUpColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.heightMultiplier * 2),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// SignUp Title
  Widget _signUpImage() {
    return Container(
      height: SizeConfig.screenHeight / 3.5,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.red),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/signup.jpg",
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _signUpTitle() {
    return Container(
      alignment: Alignment.center,
      child: Text("Sign Up",
          style: GoogleFonts.montserratAlternates(
              color: signUpColor,
              fontSize: SizeConfig.textMultiplier * 3.6,
              fontWeight: FontWeight.w500)),
    );
  }

// First name TextField
  Widget _buildFirstName() {
    return MyTextFormField(
      validator: FormValidation.nameValidation,
      prefixIcon:
          Icon(Icons.text_fields, size: SizeConfig.imageSizeMultiplier * 4.5),
      keyboardType: TextInputType.text,
      labelText: "First name",
      hintText: "Enter Your First Name",
      onSaved: (value) => _firstName = value,
      isDense: true,
    );
  }

// Last name TextField
  Widget _buildLastName() {
    return MyTextFormField(
      validator: FormValidation.nameValidation,
      prefixIcon:
          Icon(Icons.text_fields, size: SizeConfig.imageSizeMultiplier * 4.5),
      keyboardType: TextInputType.text,
      labelText: "Last name",
      hintText: "Enter Your Last Name",
      onSaved: (value) => _lastName = value,
      isDense: true,
    );
  }

// Email TextField
  Widget _buildEmail() {
    return MyTextFormField(
      validator: FormValidation.emailValidation,
      prefixIcon: Icon(Icons.email, size: SizeConfig.imageSizeMultiplier * 4.5),
      keyboardType: TextInputType.emailAddress,
      labelText: "Email address",
      hintText: "Enter Your Email",
      onSaved: (value) => _emailID = value,
      isDense: true,
    );
  }

// Phone number TextField
  Widget _buildPhoneNumber() {
    return MyTextFormField(
      validator: FormValidation.phoneNumberValidation,
      prefixIcon: Icon(Icons.phone, size: SizeConfig.imageSizeMultiplier * 4.5),
      keyboardType: TextInputType.number,
      labelText: "Phone number",
      hintText: "Enter Your Phone Number",
      onSaved: (value) => _phoneNumber = value,
      isDense: true,
    );
  }

// Password TextField
  Widget _buildPassword() {
    return MyTextFormField(
      validator: FormValidation.passwordValidation,
      prefixIcon: Icon(Icons.lock, size: SizeConfig.imageSizeMultiplier * 4.5),
      keyboardType: TextInputType.text,
      labelText: "Password",
      hintText: "Enter Your Password",
      onSaved: (value) => _password = value,
      isDense: true,
    );
  }

// SignUp Button
  Widget _signUpButton() {
    return CustomBTN(
      onPressed: _validateAndSignUp,
      //onPressed: _submit,
      minWidth: double.infinity,
      height: SizeConfig.heightMultiplier * 5,
      text: "Create Account",
      color: signUpColor,
      textColor: Colors.white,
    );
  }

  Future<void> _submit() async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.createUserWithEmailAndPassword(emailID, password);
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sign in failed'),
              content: Text(e.toString()),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }
  }

  // Validate, Save and SignUp
  void _validateAndSignUp() async {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      print("Successfully Sign Up");
      _submit();
    } else {
      setState(() {
        _autoValidate = true;
        print("Fail to signup ");
      });
    }
  }
}
