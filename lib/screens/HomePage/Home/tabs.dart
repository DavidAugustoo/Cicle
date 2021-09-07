import 'package:cicle/screens/HomePage/Home/Artigos/card.dart';
import 'package:cicle/screens/HomePage/Home/Guias/guias.dart';
import 'package:cicle/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'Teste/quiz_page.dart';
import 'Teste/quizhome.dart';

class Tabhome extends StatefulWidget {
  const Tabhome({Key? key}) : super(key: key);

  @override
  _TabhomeState createState() => _TabhomeState();
}

class _TabhomeState extends State<Tabhome> {
  var artigos = GoogleFonts.inter();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
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
          body: TabBarView(
            children: <Widget>[
              Cards(),
              QuizHome(),
              Guias(),
            ],
          ),
        ),
      );
    });
  }
}
