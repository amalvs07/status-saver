import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constant.dart';
import '../../../provider/getPermissionManager.dart';
import 'widgets/saved_image_gridview.dart';
class SavedImageHome extends StatelessWidget {
  const SavedImageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PermissionManager>(
      builder: (context, value, child) {
        if (value.storagePermissionCheck == 1) {
      
         
            return Scaffold(
              body: SavedImageGridView(
                color: Colors.white,
              ),
            );
          
        } else {
          return Scaffold(
            body: Center(
              child: TextButton(
                child: Text(
                 AppConstants.translations[AppConstants.data().toString()]!['permissionbutton']!,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                onPressed: () {
                  value.requestPermission();
                },
              ),
            ),
          );
        }
      },
    );
  }
}
