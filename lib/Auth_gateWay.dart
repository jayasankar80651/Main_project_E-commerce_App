import 'package:e_commerce_app/Home_Screen.dart';
import 'package:e_commerce_app/singin_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator(),);
      }else {
        if(snapshot.hasData){
          return const HomePage();
        }
        return const  SigninPage();
      }
     
     });
  }
}