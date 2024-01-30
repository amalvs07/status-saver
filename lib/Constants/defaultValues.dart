// import 'dart:developer';
// import 'package:hive_flutter/hive_flutter.dart';

// import '../utils/domain/storedetails.dart';

// Box<Storedetails> dataBox = Hive.box<Storedetails>('DataBox');

// List<Storedetails> datmodelList = dataBox.values.toList();
// if (datmodelList.isNotEmpty) {
//   var storedetails = datmodelList.first;
//   log('Element: ${storedetails.lang}, ${storedetails.mode}, ${storedetails.WhatsAppLocationPath}');
//   dark = storedetails.mode;
//   langcode = storedetails.lang;
//   whatsappPath = storedetails.WhatsAppLocationPath;
// }


class NewValues{
  static String langcode="en";
  static bool darkMode=false;
  static String whatsappPath = "/storage/emulated/0/Android/com.whatsapp/";
  static int selectedOrNot=0;
}
  
