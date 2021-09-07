import 'package:cicle/screens/HomePage/Home/Teste/quiz_page.dart';
import 'package:cicle/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 6.h),
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/cicle-ccd15.appspot.com/o/trofeu.png?alt=media&token=36392972-e481-42b3-a1c2-f17c715bdad4',
                width: 50.w,
              ),
              Text(
                'Teste seus',
                style: GoogleFonts.inter(
                  color: AppColors.gray,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'conhecimentos!',
                style: GoogleFonts.inter(
                  color: AppColors.gray,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Responda o máximo de perguntas que conseguir. Ao final do teste, você será informado de quantos pontos conseguiu. Boa sorte!',
                style: GoogleFonts.inter(
                  color: AppColors.gray,
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 90.w,
                height: 10.h,
                child: ElevatedButton(
                  child: Text(
                    'Iniciar',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPrimary: Colors.white,
                    primary: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
