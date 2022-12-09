import 'package:firebase/ui/auth/signin_with_google-&_facebook/models/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginController with ChangeNotifier{
  //object
  var _googleSignin=GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;
  //function for google sign in
 googlesignin() async{
   //
    this.googleSignInAccount= await _googleSignin.signIn();
    //inserting values to our user model
   this.userDetails=new UserDetails(
    displayName: this.googleSignInAccount!.displayName,
     email: this.googleSignInAccount!.email,
     photoURL: this.googleSignInAccount!.photoUrl,
   );
notifyListeners();


  }
 // facebook login
  facebookSignin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );
    if (result.status == LoginStatus.success) {
      final reguestData = await FacebookAuth.i.getUserData(
        fields: "email,name,picture",
      );
      this.userDetails = new UserDetails(
        displayName: reguestData["name"],
        email: reguestData["email"],
        photoURL: reguestData["pictue"]["data"]["URl"] ?? "",
      );
      notifyListeners();
    }
    //log ou function

  }
  logout() async {
   await FacebookAuth.i.logOut();
    googleSignInAccount = await _googleSignin.signOut();
    userDetails = null;
    notifyListeners();
  }

}