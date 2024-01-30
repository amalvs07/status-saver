import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/Constants/constant.dart';

class GetSavedDataProvider extends ChangeNotifier {
   bool _isWhatsappAvaliable = false;
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;
    bool get isWhatsappAvaliable => _isWhatsappAvaliable;

  void getSavedData(String extention) async {
    var storage = await Permission.manageExternalStorage.status;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    // if (storage.isDenied) {
    //   if (deviceInfo.version.sdkInt > 32) {
    //     await Permission.photos.request();
    //     await Permission.manageExternalStorage.request();
    //   } else {
    //     await Permission.storage.request();
    //     await Permission.manageExternalStorage.request();
    //   }

    //   log("Granded before");
    // }
    if (storage.isGranted) {
      final directorys = Directory(AppConstants.NewPath);
      log(directorys.toString());

      if (directorys.existsSync()) {
        final items = directorys.listSync();

        if (extention == ".mp4") {
          _getVideos =
              items.where((element) => element.path.endsWith(".mp4")).toList();
          notifyListeners();
        } else if (extention == ".jpg") {
          _getImages =
              items.where((element) => element.path.endsWith(".jpg")).toList();
          notifyListeners();
        } else {
          _getImages = [];
          _getVideos = [];
        }
          _isWhatsappAvaliable = true;
          notifyListeners();
      }else{
          _isWhatsappAvaliable = false;
          notifyListeners();
      }
    }
  }
}
