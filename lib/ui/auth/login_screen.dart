import 'package:firebase/ui/auth/forgot_passward.dart';
import 'package:firebase/ui/auth/login_with_phone.dart';
import 'package:firebase/ui/auth/signup_screen.dart';
import 'package:firebase/ui/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase/widgets/round_butten.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading=false;
  final  emailController=TextEditingController();
  final passwardController =TextEditingController();
  final  _formkey=GlobalKey<FormState>();
  final FirebaseAuth _auth =FirebaseAuth.instance;
  bool obsecureText=true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwardController.dispose();
  }
  void login(){
    setState(() {
      loading=false;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwardController.text).then((value){
          Utilities().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));
          setState(() {
            loading=false;
          });

    }).onError((error, stackTrace){
      debugPrint(error.toString());
      Utilities().toastMessage(error.toString());
      setState(() {
        loading=false;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child:  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text("Login"),
             backgroundColor: Colors.deepPurple,
            ),
            body: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/30),
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
                          SizedBox(height: MediaQuery.of(context).size.height/30,),
                          TextFormField(
                            obscureText:obsecureText,
                            controller: passwardController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                              hintText: "Passward",
                              prefixIcon: const Icon(Icons.visibility,color: Colors.deepPurple,),
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      obsecureText=!obsecureText;
                                    });
                                  },
                                  child:  Icon(obsecureText? Icons.visibility:Icons.visibility_off,color: Colors.deepPurple,)),
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
                                return "Please Enter Passward";
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                        ],
                  )),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Center(child:
                         RoundButten(title: 'Login',
                           onTap: (){
                           if(_formkey.currentState!.validate()){
                             login();
                             setState(() {
                               loading=loading;
                             });

                           }

                               },
                            )),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context)=>const ForgotPassward()));
                            },
                            child: const Text("Forgot Passward",style: TextStyle
                              (color: Colors
                                .deepPurple,fontSize: 15,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text("Don't have an account: ",style: TextStyle(fontSize: 15)),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                            },
                            child: const Text("Sign Up",style: TextStyle(color: Colors.deepPurple,fontSize: 15,fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginWithPhone()));

                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/15,
                      width: MediaQuery.of(context).size.width/1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2,color: Colors.deepPurple),
                      ),
                      child: const Center(
                        child: Text("Login with phone",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));

                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height/15,
                      width: MediaQuery.of(context).size.width/1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2,color: Colors.deepPurple),
                      ),
                      child: const Center(
                        child: Text("POST SCREEN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
