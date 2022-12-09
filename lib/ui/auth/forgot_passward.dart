import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_butten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPassward extends StatefulWidget {
  const ForgotPassward({Key? key}) : super(key: key);

  @override
  State<ForgotPassward> createState() => _ForgotPasswardState();
}

class _ForgotPasswardState extends State<ForgotPassward> {
  final  emailController=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Forgot passward"),
      ),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                hintText: "Email",
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
                  return "Please Enter Email";
                }
                else{
                  return null;
                }
              },
            ),
          ),
          SizedBox(height: 40,),
          RoundButten(title: "Forgot", onTap: (){
         auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) => {
           Utilities().toastMessage('We have send Verification code to your '
               'email'),
         }).onError((error, stackTrace) =>{
           Utilities().toastMessage(error.toString()),
         });
          })
        ],
      ),
    );
  }
}
