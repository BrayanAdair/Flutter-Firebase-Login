import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/ui/auth/login_with_phone.dart';
import 'package:login/ui/auth/posts/post_screen.dart';
import 'package:login/ui/auth/signup_screen.dart';
import 'package:login/utils/utils.dart';
import 'package:login/widget/round_button.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    setState((){
      loading = true;
    });
    _auth
    .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text.toString())
      .then((value) {
        Utils().toastMessage(value.user!.email.toString());
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostScreen()));
      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
      });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          helperText: 'Mail con dominio @utvam.edu.mx',
                          prefixIcon: Icon(Icons.alternate_email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresa tu mail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.security)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingresa la contraseña';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No tienes cuenta?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text('Registrarse'))
                      ],
                    ),
                      
                  ],
                )),
            RoundButton(
              title: 'Login',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  login();
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginWithPhoneNumber()));
              },
            
            child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange.shade900)),
                          child: Center(child: Text("Inicia con un Telefono")),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
