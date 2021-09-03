import 'package:cicle/screens/HomePage/HomePage.dart';
import 'package:cicle/screens/signin.dart';
import 'package:cicle/screens/splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Navigation/navigate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Navigate.routes,
      home: Splash(),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => MyApp(), // Wrap your app
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       locale: DevicePreview.locale(context), // Add the locale here
//       builder: DevicePreview.appBuilder, // Add the builder here
//       home: HomePage(),
//     );
//   }
// }
