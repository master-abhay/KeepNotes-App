import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:keep_notes/services/athentication.dart';

import '../home.dart';
import 'Button.dart';
import 'TextField.dart';
import 'color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
              textField(
                  context: context,
                  obscureText: false,
                  hintText: "Email",
                  icon: Icons.email,
                  trailingIcon: null,
                  controller: _emailController),
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
                  controller: _passwordController),
              SizedBox(
                height: mq.height * 0.002,
              ),

              loginButton(
                  buttonText: "Login",
                  context: context,
                  buttonPaddingHorizontal: 0.09,
                  buttonPaddingVertical: 0.006,
                  buttonRadius: 10,
                  textColor: Colors.white,
                  textSize: 25,
                  gradientBegin: Alignment.topLeft,
                  gradientEnd: Alignment.bottomRight,
                  colorsList: [MyColor.splashGreen, Colors.green],
                  execute: () {
                    print(_emailController.text + _passwordController.text);
                  }),

              //Don't have account text
              InkWell(
                onTap: () {
                  print(
                      "Creating Account in Login Page..........................");
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
                onPressed: () async{
                  await signInWithGoogle();

                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
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
