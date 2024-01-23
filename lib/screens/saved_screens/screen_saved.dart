import 'package:flutter/material.dart';
import 'package:status_saver/Constants/constant.dart';


import 'images/saved_image.dart';
import 'videos/saved_video.dart';

class ScreenSaved extends StatelessWidget {
  const ScreenSaved({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:  TabBar(
           indicatorColor: Colors.green,
           dividerColor: Colors.transparent,
            tabs: [
              Tab(
                // icon: Icon(Icons.image),

                child: Text(
                  AppConstants.translations[AppConstants.data().toString()]!['image']! ,
                  style: TextStyle(
                    
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18),
                ),
              ),
              Tab(
                // icon: Icon(Icons.video_collection_rounded),
               child: Text(
                  AppConstants.translations[AppConstants.data().toString()]!['video']!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body:const TabBarView(
          children: [
            SavedImageHome(),
            SavedVideoHome(),
          ],
        ),
      ),
    );
  }
}
