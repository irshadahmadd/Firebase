import 'package:firebase/ui/auth/login_screen.dart';
import 'package:firebase/ui/auth/signin_with_google-&_facebook/google-facebook_login_page.dart';
import 'package:firebase/ui/auth/signin_with_google-&_facebook/controllers/login_controller.dart';
import 'package:firebase/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../widgets/round_butten.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwardController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool obsecureText = true;

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwardController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwardController.text.toString())
        .then((value) {
      setState(() {
        loading = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utilities().toastMessage(error.toString());
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign Up"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        hintText: "Email",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 2)),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    TextFormField(
                      obscureText: obsecureText,
                      controller: passwardController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        hintText: "Passward",
                        prefixIcon: const Icon(
                          Icons.visibility,
                          color: Colors.deepPurple,
                        ),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obsecureText = !obsecureText;
                              });
                            },
                            child: Icon(
                              obsecureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.deepPurple,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 2)),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Passward";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Center(
                child: RoundButten(
              title: 'Sign Up',
              loading: loading,
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  signUp();
                }
              },
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account: ",
                      style: TextStyle(fontSize: 15)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            const Center(
              child: Text(
                "Sign In with",
                style: TextStyle(color: Colors.deepPurple, fontSize: 17),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GFLogin()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                          width: 120,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset("assets/google.png")),
                      const SizedBox(height: 7,),
                      const Text("Google"),
                    ],
                  ),
                Column(
                  children: [
                    Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset("assets/facbook.png")),
                    const SizedBox(height: 7,),
                    const Text("Facebook"),
                  ],
                ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }



}
