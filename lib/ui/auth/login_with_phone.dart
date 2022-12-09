import 'package:firebase/ui/auth/varify_code_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_butten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);
  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}
class _LoginWithPhoneState extends State<LoginWithPhone> {
  final phonenumbercontroller=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Login with Phone"),
              ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            TextFormField(
              controller: phonenumbercontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                hintText: "Phone number",
                prefixIcon: const Icon(Icons.call,color: Colors.deepPurple,),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.deepPurple,width: 2)

                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.blueAccent,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    )),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    )),
                disabledBorder: InputBorder.none,
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "Please Enter phone number";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            RoundButten(title: 'Login',loading: loading, onTap: (){

              setState(() {
                loading = true ;
              });
              auth.verifyPhoneNumber(
                  phoneNumber: phonenumbercontroller.text,
                  verificationCompleted: (_){
                    setState(() {
                      loading = false ;
                    });
                  },
                  verificationFailed: (e){
                    setState(() {
                      loading = false ;
                    });
                    Utilities().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId , int? token){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>  VarifyCodeScreen(verificationId: verificationId ,)));
                    setState(() {
                      loading = false ;
                    });
                  },
                  codeAutoRetrievalTimeout: (e){
                    Utilities().toastMessage(e.toString());
                    setState(() {
                      loading = false ;
                    });
                  });
            })
          ],
        ),
      ),
    );
  }
}
