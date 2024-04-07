import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Button.dart';
import 'TextField.dart';
import 'Toast.dart';
import 'color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

signUp() async {
  setState(() {
    isLoading = true;
  });
  _firebaseAuth
      .createUserWithEmailAndPassword(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString())
      .then((value) {
    setState(() {
      isLoading = false;
    });
    Utils().showToast(message: value.user!.email.toString() + " Your ccount Created Successfully");
    // Handle successful registration if needed
  }).catchError((error) {
    setState(() {
      isLoading = false;
    });
    Utils().showToast(message: error.toString());
  });
}

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("signUp"),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TextField email
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textField(
                          context: context,
                          obscureText: false,
                          hintText: "Email",
                          icon: Icons.email,
                          trailingIcon: null,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(
                        height: mq.height * 0.002,
                      ),
                      //TextField password
                      textField(
                          context: context,
                          obscureText: true,
                          hintText: "Password",
                          icon: Icons.password,
                          trailingIcon: null,
                          controller: _passwordController,
                          keyboardType: TextInputType.text),
                      SizedBox(
                        height: mq.height * 0.002,
                      ),
                    ],
                  )),

              loginButton(
                  buttonText: "SignUp",
                  context: context,
                  loading: isLoading,
                  buttonPaddingHorizontal: 0.09,
                  buttonPaddingVertical: 0.006,
                  buttonRadius: 10,
                  textColor: Colors.white,
                  textSize: 25,
                  gradientBegin: Alignment.topLeft,
                  gradientEnd: Alignment.bottomRight,
                  colorsList: [MyColor.splashGreen, Colors.green],
                  execute: () {
                    if (_formKey.currentState!.validate()) {
                     signUp();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
