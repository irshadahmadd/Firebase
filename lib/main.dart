import 'package:firebase/ui/auth/signin_with_google-&_facebook/controllers/login_controller.dart';
import 'package:firebase/ui/auth/signin_with_google-&_facebook/google-facebook_login_page.dart';
import 'package:firebase/ui/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create:(_)=>LoginController(),
          child: const GFLogin(),
          ),
        ],
        child: Builder(builder: (BuildContext context){
          return  const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },)

    );
  }
}

