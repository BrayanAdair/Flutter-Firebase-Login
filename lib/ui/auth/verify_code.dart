import 'package:login/ui/auth/posts/post_screen.dart';

import 'package:login/utils/utils.dart';
import 'package:login/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  
  bool loading = false;
  final verifyCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: verifyCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '6 Digitos'),
            ),
            SizedBox(
              height: 100,
            ),
            RoundButton(title: 'Verify', 
            loading: loading,
            onTap: ()async {
              setState(() {
                loading = true;
              });
              final credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: 
                verifyCodeController.text.toString()
              );
              try {
                await auth.signInWithCredential(credential);
                Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=>
                  PostScreen()
                  ));
              } catch (e) {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(e.toString());
              }
            })     
          ],
        ),
     ),
);
}
}