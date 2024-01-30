import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';

import '../../Constants/constant.dart';
import '../../provider/getPermissionManager.dart';

import '../../utils/domain/storedetails.dart';
import '../widgets/custom_image_gridview.dart';

class ScreenImage extends StatelessWidget {
  const ScreenImage({super.key});
  @override
  Widget build(BuildContext context) {
    Box<Storedetails> dataBox = Hive.box<Storedetails>('DataBox');
    return Consumer<PermissionManager>(
      builder: (context, value, child) {
        if (value.storagePermissionCheck == 1) {
          List<Storedetails> datmodelList = dataBox.values.toList();
          log(datmodelList.toString());
          int selected=0 ;
          for (var storedetails in datmodelList) {
            log('Element: ${storedetails.lang}, ${storedetails.mode},${storedetails.whatsappfolderpath},${storedetails.selectedOrNot}');
            selected = storedetails.selectedOrNot;
          }
          if (selected != 1) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConstants.translations[AppConstants.data()
                              .toString()]!['folderbuttonmessage']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0, color: Colors.green),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          child: Text(
                            AppConstants.translations[AppConstants.data()
                                .toString()]!['folderbutton']!,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green),
                          ),
                          onPressed: () {
                            value.checkCorrectOrNot();
                          },
                        ),
                      ]),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: CustomImageGridView(
                color: Colors.white,
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: TextButton(
                child: Text(
                  AppConstants.translations[AppConstants.data().toString()]![
                      'permissionbutton']!,
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
