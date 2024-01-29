import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/Constants/constant.dart';

class GetStatusProvider extends ChangeNotifier {
  bool _isWhatsappAvaliable = false;
    bool _isPermisionAvaliable = false;
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  bool get isWhatsappAvaliable => _isWhatsappAvaliable;
  bool get isPermisionAvaliable => _isPermisionAvaliable;
  void getDirect(String extention) async {
    bool permissionStatus;
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

      log("Granded before"); // it should print PermissionStatus.granted
    }
    if (storage.isGranted) {
     
  // Create a Directory object
  String folderPath=AppConstants.NewPath;
  Directory folder = Directory(folderPath);

  // Check if the folder doesn't exist, then create it
  if (!folder.existsSync()) {
    folder.createSync(recursive: true); // 'recursive: true' creates parent directories if they don't exist
    print('Folder created: $folderPath');
  } else {
    print('Folder already exists: $folderPath');
  }

      Directory? directory = await getExternalStorageDirectory();

      if (directory != null) {
        // log(directory.path);

        final directoryPath = "${AppConstants.WHATSAPP_PATH}";
        final directorys = Directory(directoryPath);
        log(directorys.toString());

        if (directorys.existsSync()) {
          final items = directorys.listSync();

          if (extention == ".mp4") {
            _getVideos = items
              .where((element) => element.path.endsWith(".mp4")).toList();
             _isPermisionAvaliable = true;
              notifyListeners();
          } else if (extention == ".jpg") {
            _getImages = items
              .where((element) => element.path.endsWith(".jpg")).toList();
           
             _isPermisionAvaliable = true;
              notifyListeners();
          } else {
            _getImages = [];
            _getVideos = [];
          }
          _isWhatsappAvaliable = true;
          notifyListeners();
          // log(items.toString());
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
