import 'dart:async';
import 'package:login/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

class splashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () =>      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()))
);
}
}