import 'package:cicle/screens/home.dart';
import 'package:cicle/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'login.dart';
import 'home.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bem vindo!",
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
                          "Por favor, faça seu cadastro",
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.gray,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                          height: 8.h,
                        ),
                        TextFormField(
                          controller: nameController,
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            labelText: "Nome",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: 5.w,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite seu nome';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 2.w,
                          height: 2.h,
                        ),
                        TextFormField(
                          controller: emailController,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite uma e-mail valido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 2.w,
                          height: 2.h,
                        ),
                        TextFormField(
                          controller: passwordController,
                          maxLength: 6,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite uma senha valida';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 2.w,
                          height: 2.h,
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.green),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )),
                            child: Text('Cadastrar',
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                registerToFb();
                              }
                            },
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
                              "Já tem uma conta?",
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.gray,
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'Entre com ela',
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
                                      builder: (context) => Login()),
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
          ),
        );
      },
    );
  }

  void registerToFb() {
    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      dbRef.child(result.user!.uid).set({
        "email": emailController.text,
        "name": nameController.text
      }).then((res) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user!.uid)),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
