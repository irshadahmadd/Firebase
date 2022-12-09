import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleSigninController with ChangeNotifier{
  //object
  var _googleSignin=GoogleSignIn();
  GoogleSignInAccount? googleSigninAccount;
  //function for login
 login() async{
   this.googleSigninAccount = await _googleSignin.signIn();
   notifyListeners();
 }
  //function for log out
  logout() async{
    this.googleSigninAccount = await _googleSignin.signOut();
    notifyListeners();
  }

}