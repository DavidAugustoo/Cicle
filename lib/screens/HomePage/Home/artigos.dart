import 'dart:async';

import 'package:cicle/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class tabhome extends StatefulWidget {
  const tabhome({Key? key}) : super(key: key);

  @override
  _tabhomeState createState() => _tabhomeState();
}

class _tabhomeState extends State<tabhome> {
  var artigos = GoogleFonts.inter();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: AppColors.green,
              labelColor: AppColors.green,
              unselectedLabelColor: AppColors.gray,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Artigos',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Teste',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Guias',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: Text("It's cloudy here"),
              ),
              Center(
                child: Text("It's rainy here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
