import 'package:cicle/screens/HomePage/Home/Teste/quiz_page.dart';
import 'package:cicle/screens/HomePage/Home/Teste/quizhome.dart';
import 'package:cicle/screens/HomePage/Home/tabs.dart';
import 'package:cicle/screens/HomePage/HomePage.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class FinishDialog {
  static Future show(
    BuildContext context, {
    required int hitNumber,
    required int questionNumber,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          title: CircleAvatar(
            backgroundColor: AppColors.green,
            maxRadius: 35.0,
            child: Icon(
              hitNumber < 6 ? Icons.warning : Icons.favorite,
              color: Colors.white,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parabéns',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Você acertou $hitNumber de $questionNumber!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray,
                ),
              ),
              Text(
                'Que tal tentar mais uma vez? Quem sabe você consegue acertar todas na próxima!',
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'JOGAR NOVAMENTE',
                style: TextStyle(color: AppColors.green),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
            TextButton(
              child: Text(
                'SAIR',
                style: TextStyle(color: AppColors.green),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, Constants.homeNavigate, (route) => false);
              },
            )
          ],
        );
      },
    );
  }
}
