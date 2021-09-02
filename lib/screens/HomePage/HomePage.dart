import 'package:cicle/screens/HomePage/Home/artigos.dart';
import 'package:cicle/screens/HomePage/Home/profile.dart';
import 'package:cicle/services/firebase_service.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  String homeicon = './assets/Navigation/Home.svg';
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    const tabhome(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: AppColors.graynavigation,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Vender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contato',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.green,
        onTap: _onItemTapped,
      ),
    );
  }

  void icone() {
    SvgPicture.asset('./assets/Navigation/Home.svg');
  }
}
