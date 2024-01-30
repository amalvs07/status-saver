import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer' as developer;

import 'package:status_saver/utils/domain/storedetails.dart';

import '../Constants/defaultValues.dart';

class PermissionManager extends ChangeNotifier {
  int? _storagePermissionCheck;

  int? get storagePermissionCheck => _storagePermissionCheck;

  int? androidSDK;

  String? _selectedDirectory;

  String? get selectedDirectory => _selectedDirectory;

  int? _containsStatusFolder;

  int? get containsStatusFolder => _containsStatusFolder;

  Box<Storedetails> dataBox = Hive.box<Storedetails>('DataBox');
  PermissionManager() {
    _init();
  }

  Future<void> _init() async {
    // Get phone SDK version first to request correct permissions.
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    androidSDK = androidInfo.version.sdkInt;

    if (androidSDK! >= 30) {
      _storagePermissionCheck = await _loadPermission();
    } else {
      _storagePermissionCheck = await _loadStoragePermission();
    }

    notifyListeners();
  }

  Future<int> _loadPermission() async {
    final _currentStatusManaged = await Permission.manageExternalStorage.status;
    return _currentStatusManaged.isGranted ? 1 : 0;
  }

  Future<int> _loadStoragePermission() async {
    final _currentStatusStorage = await Permission.storage.status;
    return _currentStatusStorage.isGranted ? 1 : 0;
  }

  Future<int> requestPermission() async {
    if (androidSDK! >= 30) {
      final _requestStatusManaged =
          await Permission.manageExternalStorage.request();
      _storagePermissionCheck = _requestStatusManaged.isGranted ? 1 : 0;
    } else {
      final _requestStatusStorage = await Permission.storage.request();
      _storagePermissionCheck = _requestStatusStorage.isGranted ? 1 : 0;
    }

    notifyListeners();
    return _storagePermissionCheck!;
  }

  Future<int> requestStoragePermission() async {
    final result = await [Permission.storage].request();
    _storagePermissionCheck = result[Permission.storage]!.isGranted ? 1 : 0;

    notifyListeners();
    return _storagePermissionCheck!;
  }

  Future<int> checkCorrectOrNot() async {
    List<Storedetails> datmodelList = dataBox.values.toList();
    log(datmodelList.toString());
   
    for (var storedetails in datmodelList) {
      log('Element: ${storedetails.lang}, ${storedetails.mode},${storedetails.whatsappfolderpath}');
            NewValues.darkMode = storedetails.mode;
      NewValues.langcode = storedetails.lang;
      NewValues.whatsappPath=storedetails.whatsappfolderpath;
      NewValues.selectedOrNot=storedetails.selectedOrNot;
    }
    String tempPath = '${NewValues.whatsappPath}/WhatsApp/Media/.Statuses';
    Directory tempFolder = Directory(tempPath);
    _containsStatusFolder = await tempFolder.exists() ? 1 : 0;
      notifyListeners();
    if (_containsStatusFolder == 1) { 
        dataBox.put("darkMode", Storedetails(mode: NewValues.darkMode, lang: NewValues.langcode,whatsappfolderpath:NewValues.whatsappPath,selectedOrNot:_containsStatusFolder!));
notifyListeners();
      return 1;
    }else{
      filePickerSS();
      notifyListeners();
    }

    return 0;
  }

  Future<int> filePickerSS() async {
    String? _selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (_selectedDirectory == null) {
      developer.log('No directory selected');
    } else {
      developer.log('Directory selected: $_selectedDirectory');

      String statusFolderPath = '$_selectedDirectory/WhatsApp/Media/.Statuses';
      Directory statusFolder = Directory(statusFolderPath);

      _containsStatusFolder = await statusFolder.exists() ? 1 : 0;
      notifyListeners();

      if (_containsStatusFolder == 1) {
        developer.log('Selected folder contains WhatsApp/Media/.Statuses');

        dataBox.put("darkMode",
            Storedetails(mode: NewValues.darkMode,lang: NewValues.langcode,whatsappfolderpath: _selectedDirectory,selectedOrNot: _containsStatusFolder!));

      } else {
        developer
            .log('Selected folder does not contain WhatsApp/Media/.Statuses');
        Fluttertoast.showToast(
          msg: "Please Select the folder contain Whatsapp Media",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
    return _containsStatusFolder!;
  }
}
