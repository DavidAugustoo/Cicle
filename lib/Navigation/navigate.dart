import 'package:cicle/screens/HomePage/HomePage.dart';

import 'package:cicle/screens/signin.dart';
import 'package:flutter/material.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/sign-in': (context) => SignIn(),
    '/home': (context) => HomePage(),
  };
}
