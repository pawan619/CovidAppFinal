import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future signInWithEmailAndPassword(String email, String password);
  Future createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<Void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFirebaseUser(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFirebaseUser);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFirebaseUser(user);
  }

  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFirebaseUser(authResult.user);
  }

  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFirebaseUser(authResult.user);
  }

  @override
  Future createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFirebaseUser(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.hashCode != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFirebaseUser(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        ),
      );
      return _userFirebaseUser(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'sign in aborted by user',
      );
    }
  }

  @override
  Future<Void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
