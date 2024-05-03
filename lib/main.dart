// import 'package:firebase_core_dart/firebase_core_dart.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_notes/Splash/splashServices.dart';
import 'package:keep_notes/services/sharedPrefrences.dart';

import 'Login/login_page.dart';
import 'Splash/splashScreen.dart';
import 'firebase_options.dart';
import 'home.dart';
//

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  getLoggedInState() async {
    LocalDataSaver.getLoginState().then((value) {
      setState(() {
        isLogin = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLoggedInState();
    print("$isLogin");
    SplashServices().isLogin(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: '/',
      // routes: {'/': (context) => SplashScreen()},

      home: isLogin ? Home() : LoginPage(),
    );
  }
}
