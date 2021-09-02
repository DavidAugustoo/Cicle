import 'package:cicle/services/firebase_service.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  User? result = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: AppColors.green,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 40.h,
                    child: Container(
                      color: AppColors.green,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 90.w,
                      height: 40.h,
                      child: SvgPicture.asset(
                        './assets/login.svg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70.w,
                        child: Column(children: [
                          Icon(
                            Icons.login_outlined,
                            size: 10.w,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'Ajude o meio ambiente e ainda ganhe com isso',
                            style: GoogleFonts.inter(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.gray),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            'Entre com sua conta do google para aproveitar todos os recursos',
                            style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.gray),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            width: 100.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(26))),
                            child: SignInButton(
                              Buttons.Google,
                              elevation: 2,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                FirebaseService service = new FirebaseService();
                                try {
                                  await service.signInwithGoogle();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Constants.homeNavigate, (route) => false);
                                } catch (e) {
                                  if (e is FirebaseAuthException) {
                                    showMessage(e.message!);
                                  }
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
