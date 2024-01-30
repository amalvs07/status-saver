

import 'dart:developer';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

import '../image_screens/screen_image.dart';
import '../saved_screens/screen_saved.dart';
import '../video_screens/screen_video.dart';
import 'widgets/custom_bottom_nav.dart';
import 'widgets/custom_drawer.dart';


class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pages = [
     ScreenImage(),
    const ScreenVideo(),
    const ScreenSaved(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        // title: const Text("Status Saver",style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //               fontSize: 20),),
        actions: [
          SizedBox(
            width: 30,
            child: GestureDetector(
              onTap: ()async{
                await LaunchApp.openApp(
                  androidPackageName: 'com.whatsapp',
                  openStore: true,
                );
                log("Message");
              },
              child: Image.asset(
                'assets/images/whatsapp.png',
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          // const Icon(Icons.share),
          // const SizedBox(
          //   width: 20,
          // ),
        ],
      ),
      drawer:const CustomDrawer(),
     body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int value, _) {
            return _pages[value];
          },
        ),
      ),
      bottomNavigationBar: const BottamNavigationWidgets(), 
    );
  }
}

