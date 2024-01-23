import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main_screens/screen_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigatorHome();
  }

  navigatorHome() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/ic_launcher.png",width: 150),
             const Padding(
               padding:  EdgeInsets.symmetric(vertical:8.0),
               child:  Text("Status Saver",style: TextStyle(
                  fontSize: 25,fontWeight: FontWeight.w900,
                  color: Colors.green,
                  decoration: TextDecoration.none,
                  
                ),),
             )
            ],
          )
          ),
    );
  }
}
