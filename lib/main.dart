import 'package:auth_form/screens/home_screen.dart';
import 'package:auth_form/screens/sign_in_screen.dart';
import 'package:auth_form/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "sign_up": (context) => SignUpScreen(),
        "sign_in": (context) => SignInScreen(),
        "Home_screen": (context) => HomeScreen(),
      },
      home:SignInScreen(),
      //===
    );
  }
}
