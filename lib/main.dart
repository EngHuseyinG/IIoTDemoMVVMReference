import 'package:demo/authentication/loginPage.dart';
import 'package:demo/cihazYonetimi/cihazYonetimiMainPage.dart';
import 'package:demo/cloudservices/database.dart';
import 'package:demo/izlenebilirlik/FlexUretimDetay.dart';
import 'package:demo/izlenebilirlik/izlenebilirlikFlexUretim.dart';
import 'package:demo/izlenebilirlik/izlenebilirlikMainPage.dart';
import 'package:demo/mainPages/mainPage.dart';
import 'package:demo/modulYonetimi/modulYonetimi.dart';
import 'package:demo/raporlama/raporlamaMainPage.dart';
import 'package:demo/viewmodels/drawerViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => drawerViewModel()),
        ChangeNotifierProvider(create: (context) => database()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/giris',

/*
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/giris':
            return CupertinoPageRoute(
                builder: (_) => loginPage(), settings: settings);
          case '/anasayfa':
            return CupertinoPageRoute(
                builder: (_) => mainPage(), settings: settings);
          case '/cihazyonetimi/anasayfa':
            return CupertinoPageRoute(
                builder: (_) => cihazYonetimiMainPage(), settings: settings);
          case '/izlenebilirlik/anasayfa':
            return CupertinoPageRoute(
                builder: (_) => izlenebilirlikMainPage(), settings: settings);
          case '/modulyonetimi/anasayfa':
            return CupertinoPageRoute(
                builder: (_) => modulYonetimiMainPage(), settings: settings);
          case '/raporlama/anasayfa':
            return CupertinoPageRoute(
                builder: (_) => raporlamaMainPage(), settings: settings);
          case '/izlenebilirlik/montaj/uretim':
            return CupertinoPageRoute(
                builder: (_) => FlexUretim(), settings: settings);
          case '/izlenebilirlik/montaj/uretim/detay':
            return CupertinoPageRoute(
                builder: (_) => Flexuretimdetay(), settings: settings);
        }
      },
*/

      routes: {
        '/giris': (context) =>  loginPage(),
        '/anasayfa': (context) =>  mainPage(),
        '/cihazyonetimi/anasayfa': (context) =>  cihazYonetimiMainPage(),
        '/izlenebilirlik/anasayfa': (context) =>  izlenebilirlikMainPage(),
        '/modulyonetimi/anasayfa': (context) =>  modulYonetimiMainPage(),
        '/raporlama/anasayfa': (context) =>  raporlamaMainPage(),
        '/izlenebilirlik/montaj/uretim' : (context) => FlexUretim(),
        '/izlenebilirlik/montaj/uretim/detay' : (context) => Flexuretimdetay(),
      },
      title: 'Teleportal 4.0',
    );
  }
}
