import 'package:flutter/material.dart';
class UserDetails{
  String? displayName;
  String? email;
  String? photoURL;
  //constructor
   UserDetails({
     this.displayName,
     this.email,
     this.photoURL});
   //we need to create map
    UserDetails.fromjson(Map<String,dynamic>json){
      displayName=json["displayName"];
      email=json["email"];
      photoURL=json["photoURL"];
    }
    //object data
Map<String,dynamic> tojson(){
      final Map<String,dynamic> data= new Map<String,dynamic>();
      data["displayName"]=this.displayName;
      data["email"]=this.email;
      data["photoURL"]=this.photoURL;
      return data;
  }

}