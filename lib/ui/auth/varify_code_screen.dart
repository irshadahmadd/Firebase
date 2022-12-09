import 'package:firebase/ui/posts/post_screen.dart';
import 'package:firebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/round_butten.dart';
class VarifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VarifyCodeScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VarifyCodeScreen> createState() => _VarifyCodeScreenState();
}

class _VarifyCodeScreenState extends State<VarifyCodeScreen> {
  final verifycodecontroller=TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify Code"),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            TextFormField(
              controller: verifycodecontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                hintText: "Enter Six Digits Code",
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
            RoundButten(title: "Verify",loading: loading, onTap: () async{
              setState(() {
                loading=true;
              });
              final credential=PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode:verifycodecontroller.text.toString(),
              );
              try{
                await   auth.signInWithCredential(credential);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PostScreen()));

              } catch(e){
                setState(() {
                  loading=false;
                  Utilities().toastMessage(e.toString());
                });
              }

            })
          ],
        ),
      ),
    );
  }
}
