import 'package:cicle/screens/registro.dart';
import 'package:cicle/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bem vindo novamente!",
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gray,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                        height: 1.h,
                      ),
                      Text(
                        "Por favor, entre com sua conta",
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 12.h,
                      ),
                      TextField(
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          labelText: "E-mail",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 5.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 2.h,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          labelText: "Senha",
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            size: 5.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              'Esqueceu a senha?',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.gray,
                              ),
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
                          child: Text('Login',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                              )),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Não tem uma conta?",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.gray,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Cadastre-se',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registro()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
