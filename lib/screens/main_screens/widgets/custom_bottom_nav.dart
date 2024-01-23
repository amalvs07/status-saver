
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import '../../../Constants/constant.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottamNavigationWidgets extends StatelessWidget {
  const BottamNavigationWidgets({super.key});

  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder(
      
        valueListenable: indexChangeNotifier,
        builder: (BuildContext context, int newindex, _) =>
        FlashyTabBar(
          
            selectedIndex: newindex,
            showElevation: true,
            onItemSelected: (index) {
              indexChangeNotifier.value = index;
            },
            items: [
              FlashyTabBarItem(
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.image),
                title:  Text(AppConstants.translations[AppConstants.data().toString()]!['image']!),
              
              ),
              FlashyTabBarItem(
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.video_collection),
                title: Text(AppConstants.translations[AppConstants.data().toString()]!['video']!),
              ),
              FlashyTabBarItem(
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                icon: const Icon(Icons.download_sharp),
                title: Text(AppConstants.translations[AppConstants.data().toString()]!['saved']!),
              ),
            ],
          )
        
      );
  }
}
  
