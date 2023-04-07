import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:login/ui/auth/posts/post_screen.dart';
import 'package:login/widget/round_button.dart';

import '../../utils/utils.dart';


class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  // final phoneNumberController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              TextFormField(
                // controller: phoneNumberController,
                controller: verificationCodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: '6 digitos'),
              ),
              SizedBox(
                height: 100,
              ),
              RoundButton(
                title: 'Verify',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: verificationCodeController.text.toString(),
                    // aqui no se si va fuera del final
                    // end del no se si va fuera
           
                  );
                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                    PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                  // pña
                },
              )
            ],
          ),
        ),
    );
  }
}