import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/getSavedDataProvider.dart';
import 'package:status_saver/utils/domain/storedetails.dart';

import 'Constants/themes.dart';
import 'provider/getStatusProvider.dart';
import 'screens/splash_screens/screen_splash.dart';


void main() async{
 
   await Hive.initFlutter();
   Hive.registerAdapter(StoredetailsAdapter());
   Hive.openBox<Storedetails>('DataBox');
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
    WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
    final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GetStatusProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GetSavedDataProvider(),
        ),
      ],
      child: AdaptiveTheme(
      light: Themes.light,
      dark: Themes.dark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,

        builder: (theme, darkTheme) => MaterialApp(
          title: 'Status Saver',
          theme: theme,
          darkTheme: darkTheme,
         
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
