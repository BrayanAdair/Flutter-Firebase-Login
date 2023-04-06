import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:login/ui/auth/posts/post_screen.dart';

class splashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(
      const Duration(seconds: 3),
       () =>      Navigator.push(context,
        MaterialPageRoute(builder: (context) => PostScreen())));
    }else{
    Timer(
      const Duration(seconds: 3),
       () =>      Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginScreen())));    
    }
}
}