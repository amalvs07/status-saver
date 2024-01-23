import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:status_saver/Constants/constant.dart';
import 'package:status_saver/utils/domain/storedetails.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

bool light = false;

String selectedLanguage = 'Select Language';

String langcode = 'en';


bool dark = false;
Box<Storedetails> dataBox = Hive.box<Storedetails>('DataBox');

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Storedetails> datmodelList = dataBox.values.toList();
                log(datmodelList.toString());
    for (var storedetails in datmodelList) {
                  log('Element: ${storedetails.lang}, ${storedetails.mode}');
                  dark=storedetails.mode;
                  langcode=storedetails.lang;
                }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 119, 222, 123),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 10),
                    child: Image.asset(
                      'assets/images/whatsapp.png',
                      width: 60,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      AppConstants.translations[langcode]!['appHeading']!,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      AppConstants.translations[langcode]!['downloadAndShare']!,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                AppConstants.translations[langcode]!['general']!,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(selectedLanguage),
              onTap: () {
                showDropdown(context, AppConstants.options);
                log(langcode.toString());
                setState(() {});
              },
              trailing: Icon(Icons.arrow_drop_down),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text(AppConstants.translations[langcode]!['darkMode']!),
              trailing: Switch(
                value: dark,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    dark = value;
                    dark
                        ? AdaptiveTheme.of(context).setDark()
                        : AdaptiveTheme.of(context).setLight();
                    dataBox.put(
                        "darkMode", Storedetails(mode: dark, lang: langcode));
                  });
                },
              ),
              onTap: () {},
            ),
            // Divider(),
            // ListTile(
            //   leading: Icon(Icons.save),
            //   title: Text(AppConstants.translations[langcode]!['autoSave']!),
            //   trailing: Switch(
            //     value: light,
            //     activeColor: Colors.green,
            //     onChanged: (bool value) {
            //       setState(() {
            //         light = value;
            //       });
            //     },
            //   ),
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(AppConstants.translations[langcode]!['about']!),
              onTap: () {
                // log(dataBox.get("darkMode").toString());
                // List<Storedetails> catModelList = dataBox.values.toList();
                // log(catModelList.toString());
                // for (var storedetails in catModelList) {
                //   log('Element: ${storedetails.lang}, ${storedetails.mode}');
                // }

                _showCustomDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showDropdown(BuildContext context, List<String> options) async {
    final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final Offset itemPosition = itemBox.localToGlobal(Offset.zero);

    String? result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        itemPosition.dx,
        itemPosition.dy + options.length * 100.0,
        itemPosition.dx + itemBox.size.width,
        itemPosition.dy,
      ),
      items: options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              option,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );

    if (result != null) {
      setState(() {
        selectedLanguage = result;
        langcode = AppConstants.optionsCode[options.indexOf(result)];
        dataBox.put("darkMode", Storedetails(mode: dark, lang: langcode));
      });
    }
  }
  
   void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Disclaimer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                   
                    
                    Text(
                      ' Status Saver is designed to help users effortlessly save and manage media content from WhatsApp statuses',
                      style: TextStyle(fontSize: 16,color: Colors.black,),textAlign: TextAlign.center,
                    ),
                     Text(
                      'How App works?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                   
                    
                    Text(
                      'It operates by accessing and retrieving media content from WhatsApp statuses.It allows users to convert image to pdf and print them.And also  download and share both images and videos shared in WhatsApp statuses',
                      style: TextStyle(fontSize: 16,color: Colors.black,),
                   textAlign: TextAlign.center ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
}