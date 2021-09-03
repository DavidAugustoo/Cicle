import 'package:cicle/themes/colors.dart';
import 'package:cicle/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:sizer/sizer.dart';

class Contato extends StatefulWidget {
  const Contato({Key? key}) : super(key: key);

  @override
  _ContatoState createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  var emailController = 'contato@cicle.com';
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(33),
                    bottomRight: Radius.circular(33),
                  )),
              height: 30.h,
              width: 100.w,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.h),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80.w,
                        child: Text(
                          'Precisa de ajuda? \nMande uma mensagem!',
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Form(
              key: _formKey,
              onChanged: (() {
                setState(() {
                  _enableBtn = _formKey.currentState!.validate();
                });
              }),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFields(
                        controller: subjectController,
                        name: "Assunto",
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Digite um assunto';
                          }
                          return null;
                        })),
                    TextFields(
                        controller: messageController,
                        name: "Message",
                        validator: ((value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _enableBtn = true;
                            });
                            return 'Escreva uma mensagem';
                          }
                          return null;
                        }),
                        maxLines: null,
                        type: TextInputType.multiline),
                    Padding(
                        padding: EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 9.h,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed))
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5);
                                    else if (states
                                        .contains(MaterialState.disabled))
                                      return Colors.black12;
                                    return AppColors
                                        .green; // Use the component's default.
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                ))),
                            onPressed: _enableBtn
                                ? (() async {
                                    final Email email = Email(
                                      body: messageController.text,
                                      subject: subjectController.text,
                                      recipients: [emailController],
                                      isHTML: false,
                                    );

                                    await FlutterEmailSender.send(email);
                                  })
                                : null,
                            child: Text('Enviar'),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      );
    });
  }
}
