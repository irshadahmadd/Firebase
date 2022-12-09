import 'package:firebase/ui/auth/signin_with_google-&_facebook/controllers/login_controller.dart';
import 'package:firebase/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class GFLogin extends StatefulWidget {
  const GFLogin({Key? key}) : super(key: key);

  @override
  State<GFLogin> createState() => _GFLoginState();
}

class _GFLoginState extends State<GFLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login With google and facebok"),
      ),
      body: Column(
        children: [
          loginwithGF(),
          GestureDetector(
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
                child: Text("Go To App",style: TextStyle(fontWeight: FontWeight
                    .bold,fontSize: 15),),
              ),
            ),
          ),
        ],
      )

    );
  }
  loginwithGF(){

    return Consumer<LoginController>(builder:(context,model,child){
      if(model.userDetails!=null) {
        return Center(
          child: logedInUi(model),
        );
      }
      else{
        return loginController(context);
      }

    });
  }
  logedInUi(LoginController model){
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: Image.network(model.userDetails!.photoURL?? "").image,
        ),
        Text(model.userDetails!.displayName?? ""),
        Text(model.userDetails!.email?? ""),
        ActionChip(
          avatar: const Icon(Icons.logout_outlined),
            label: const Text("Log Out"),
          onPressed: (){
            Provider.of<LoginController>(context, listen: false).logout();
          },
        )
      ],
    );
  }
  loginController(BuildContext context ){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Provider.of<LoginController>(context,listen: false)
                  .googlesignin();
            },
            child: Container(
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image.asset("assets/google.png")),
          ),
          GestureDetector(
              onTap: (){
                Provider.of<LoginController>(context,listen: false)
                    .facebookSignin();
              },
              child: Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset("assets/facbook.png")),)
        ],
      ),
    );
  }
}
