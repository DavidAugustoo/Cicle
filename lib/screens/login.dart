import 'package:cicle/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:cicle/themes/text_style.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bem vindo novamente!",
                      style: TextStyles.title,
                    ),
                    SizedBox(
                      width: 5.w,
                      height: 1.h,
                    ),
                    Text(
                      "Por favor, entre com sua conta",
                      style: TextStyles.subtitle,
                    ),
                    SizedBox(
                      width: 2.w,
                      height: 12.h,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "E-mail",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                      height: 2.h,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "Senha",
                        prefixIcon: Icon(Icons.lock_outlined),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyles.subtitle,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 2.w,
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 9.h,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.green),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            )),
                        child: Text('Login'),
                        onPressed: () {},
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Não tem uma conta?",
                          style: TextStyles.subtitle,
                        ),
                        TextButton(
                          child: Text(
                            'Cadastre-se',
                            style: TextStyles.subtitlegreen,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
