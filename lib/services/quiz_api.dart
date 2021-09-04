import 'dart:convert';

import 'package:cicle/screens/HomePage/Home/Teste/models/questions.dart';
import 'package:http/http.dart' as http;

class QuizApi {
  static Future<List<Question>> fetch() async {
    try {
      var url =
          'https://script.google.com/macros/s/AKfycbyxVWMjsYs4m7m_iQ0bzM-JfLy4_dxMG9kSNyAdldpbqB9pcK4/exec';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return List<Question>.from(
            data["questions"].map((x) => Question.fromMap(x)));
      } else {
        return <Question>[];
      }
    } catch (error) {
      print(error);
      return <Question>[];
    }
  }
}
