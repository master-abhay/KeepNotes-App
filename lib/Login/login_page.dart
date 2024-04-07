import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:keep_notes/Login/signUp_page.dart';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:keep_notes/services/athentication.dart';

import '../home.dart';
import 'Button.dart';
import 'TextField.dart';
import 'Toast.dart';
import 'color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  login() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => {
                Utils().showToast(message: value.user!.email.toString()),
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home())),
                setState(() {
                  isLoading = false;
                })
              })
          .catchError((onError) {
        Utils().showToast(message: onError.toString());
      });
    } catch (error) {
      print("Error while logging in with email and password");
      setState(() {
        isLoading = false;
      });
    }
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // //Image
              // SizedBox(
              //   height: mq.height * 0.2,
              //   width: mq.width * 0.3,
              //   child: Image.asset("images/splashLogo.png"),
              // ),
              // SizedBox(
              //   height: mq.height * 0.0001,
              // )
              //FoodMarket Text
              // ,
              // Text("Food Market",
              //     style: const TextStyle(
              //         fontSize: 40.0, color: MyColor.splashBlack)),
              //
              // //Deliver your favourite food text
              // const Text(
              //   "Deliver your favourite food",
              //   style: TextStyle(fontSize: 15, color: MyColor.splashGreen),
              // ),
              //
              // SizedBox(
              //   height: mq.height * 0.01,
              // ),
              //
              // //Login to your Account Text
              // const Text(
              //   "Login to your account",
              //   style: TextStyle(fontSize: 23, color: MyColor.splashGreen),
              // ),
              // SizedBox(
              //   height: mq.height * 0.03,
              // ),

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
                  buttonText: "Login",
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
                  execute: () async {
                    if (_formKey.currentState!.validate()) {
                      await login();
                    }
                  }),

              //Don't have account text
              InkWell(
                onTap: () {
                  print(
                      "Creating Account in Login Page..........................");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: const Text(
                  "Don't have Account! create one.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              //or Text
              const Text(
                "or",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: mq.height * 0.002,
              ),

              //continue with Text
              const Text(
                "Continue with",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: mq.height * 0.002,
              ),

              //Row Containing Two singIn buttons google and facebook

              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  await signInWithGoogle();

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),

              //Login Button

              //Designed by masterTeck text
            ],
          ),
        ),
      ),
    );
  }
}
