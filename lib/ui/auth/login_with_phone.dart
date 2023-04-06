import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:login/ui/auth/verify_code.dart';
import 'package:login/widget/round_button.dart';
import '../../utils/utils.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: '+52 771 1896 273'),
          ),
          SizedBox(
            height: 80,
          ),
          RoundButton(
              title: 'Login',
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phoneNumberController.text,
                    verificationCompleted: (_) {
                                      setState(() {
                  loading = false;
                });
                
                    },
                    verificationFailed: (e) {
                                      setState(() {
                  loading = false;
                });
                      Utils().toastMessage(e.toString());
                    },
                    codeSent: (String VerificationId, int? Token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                    verificationId: VerificationId,
                                  )));
                                                  setState(() {
                  loading = true;
                });
                    },
                    codeAutoRetrievalTimeout: (e) {
                                      setState(() {
                  loading = true;
                });
                      Utils().toastMessage(e.toString());
                    });
              })
        ]),
     ),
);
}
}