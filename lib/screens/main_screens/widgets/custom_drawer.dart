import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../Constants/constant.dart';
import '../../../Constants/defaultValues.dart';
import '../../../utils/domain/storedetails.dart';





class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

bool light = false;

String selectedLanguage = 'Select Language';




Box<Storedetails> dataBox = Hive.box<Storedetails>('DataBox');



class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   List<Storedetails> datmodelList = dataBox.values.toList();
    log(datmodelList.toString());
   
    for (var storedetails in datmodelList) {
      log('Element: ${storedetails.lang}, ${storedetails.mode},${storedetails.whatsappfolderpath}');
            NewValues.darkMode = storedetails.mode;
      NewValues.langcode = storedetails.lang;
      NewValues.whatsappPath=storedetails.whatsappfolderpath;
      NewValues.selectedOrNot=storedetails.selectedOrNot;
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
                      AppConstants.translations[NewValues.langcode]!['appHeading']!,
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
                      AppConstants.translations[NewValues.langcode]!['downloadAndShare']!,
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
                AppConstants.translations[NewValues.langcode]!['general']!,
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
                log(NewValues.langcode.toString());
                setState(() {});
              },
              trailing: Icon(Icons.arrow_drop_down),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text(AppConstants.translations[NewValues.langcode]!['darkMode']!),
              trailing: Switch(
                value: NewValues.darkMode,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    NewValues.darkMode = value;
                    NewValues.darkMode
                        ? AdaptiveTheme.of(context).setDark()
                        : AdaptiveTheme.of(context).setLight();
        dataBox.put("darkMode", Storedetails(mode: NewValues.darkMode, lang: NewValues.langcode,whatsappfolderpath:NewValues.whatsappPath,selectedOrNot:NewValues.selectedOrNot));
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
              title: Text(AppConstants.translations[NewValues.langcode]!['about']!),
              onTap: () {
                // log(dataBox.get("darkMode").toString());
                // List<Storedetails> catModelList = dataBox.values.toList();
                // log(catModelList.toString());
                // for (var storedetails in catModelList) {
                //   log('Element: ${storedetails.lang}, ${storedetails.mode}');
                // }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 20,),
                            Text(
                              "Disclaimer",
                              style: textStyle,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Save WhatsApp statuses effortlessly. Enjoy dark mode, language options, and an ad-free experience for seamless media preservation",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20,),
                            Text(
                              "How to App works?",
                              style: textStyle,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "Sharing, printing, and saving WhatsApp statuses is a breeze with Status Saver. Simply select the desired status, use the share option for quick sharing, or print images directly from the app. Enjoy the convenience of preserving your favorite moments effortlessly.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20,),
                            Text(
                              "Limitations",
                              style: textStyle,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "App relies on device storage permissions. Printing may require additional app integration",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    );
                  },
                );
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
        NewValues.langcode = AppConstants.optionsCode[options.indexOf(result)];
        dataBox.put("darkMode", Storedetails(mode: NewValues.darkMode, lang: NewValues.langcode,whatsappfolderpath:NewValues.whatsappPath,selectedOrNot:NewValues.selectedOrNot));
      });
    }
  }


  
}
