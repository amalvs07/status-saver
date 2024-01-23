import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/Constants/constant.dart';

class GetStatusProvider extends ChangeNotifier {
  bool _isWhatsappAvaliable = false;
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvaliable => _isWhatsappAvaliable;

  void getDirect(String extention) async {
    bool permissionStatus = false;
    var status = await Permission.storage.status;
    var photo = await Permission.photos.status;
    var storage = await Permission.manageExternalStorage.status;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    
    if (storage.isDenied) {
      if (deviceInfo.version.sdkInt > 32) {
        await Permission.photos.request();
        await Permission.manageExternalStorage.request();
      } else {
        await Permission.storage.request();
        await Permission.manageExternalStorage.request();
      }
      
      log("Permission not granted");
      _isWhatsappAvaliable = false; // Set the flag to false if permission is not granted
      notifyListeners();
      return;
    }

    if (photo.isGranted) {
      // Create a Directory object
      String folderPath = AppConstants.NewPath;
      Directory folder = Directory(folderPath);

      // Check if the folder doesn't exist, then create it
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
        print('Folder created: $folderPath');
      } else {
        print('Folder already exists: $folderPath');
      }

      Directory? directory = await getExternalStorageDirectory();

      if (directory != null) {
        final directoryPath = "${AppConstants.WHATSAPP_PATH}";
        final directorys = Directory(directoryPath);

        if (directorys.existsSync()) {
          final items = directorys.listSync();

          if (extention == ".mp4") {
            _getVideos = items
                .where((element) => element.path.endsWith(".mp4"))
                .toList();
            notifyListeners();
          } else if (extention == ".jpg") {
            _getImages = items
                .where((element) => element.path.endsWith(".jpg"))
                .toList();
            notifyListeners();
          } else {
            _getImages = [];
            _getVideos = [];
          }
          _isWhatsappAvaliable = true;
          notifyListeners();
        } else {
          log("No WhatsApp directory");
          _isWhatsappAvaliable = false;
          notifyListeners();
        }
      } else {
        log("External storage directory not available or permission not granted");
      }
    }
  }
}
