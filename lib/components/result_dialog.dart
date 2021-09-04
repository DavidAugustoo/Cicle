import 'package:cicle/screens/HomePage/Home/Teste/models/questions.dart';
import 'package:cicle/themes/colors.dart';
import 'package:flutter/material.dart';

class ResultDialog {
  static Future show(
    BuildContext context, {
    required Question question,
    required bool correct,
    required Function onNext,
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
            backgroundColor: correct ? Colors.green : Colors.red,
            child: Icon(
              correct ? Icons.check : Icons.close,
              color: Colors.grey.shade900,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                question.question,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                correct ? 'Você acertou!' : 'Você errou! O correto é:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: correct ? Colors.green : Colors.red,
                ),
              ),
              Text(
                question.answer1,
                style: TextStyle(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: const Text('PRÓXIMO'),
              onPressed: () {
                Navigator.of(context).pop();
                onNext();
              },
            )
          ],
        );
      },
    );
  }
}
