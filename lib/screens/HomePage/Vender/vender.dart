import 'package:cicle/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Vender extends StatefulWidget {
  const Vender({Key? key}) : super(key: key);

  @override
  _VenderState createState() => _VenderState();
}

class _VenderState extends State<Vender> {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isRetrieved = false;
  final _formKey = GlobalKey<FormState>();
  final estados = ["9:00 - 10:00", "15:00 - 16:00", "19:00 - 20:00"];
  String? dropdownValue = '9:00 - 10:00';
  final quantidadeController = TextEditingController();
  final enderecoController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("pedidos");
  QuerySnapshot<Map<String, dynamic>>? cachedResult;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: !isRetrieved
              ? FutureBuilder(
                  future: getImages(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      isRetrieved = true;
                      cachedResult = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 100.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Escolha uma',
                                    style: GoogleFonts.inter(
                                      color: AppColors.green,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'categoria',
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 230,
                                        childAspectRatio: 2 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    borderOnForeground: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    elevation: 1,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            Image.network(
                                              snapshot.data!.docs[index]
                                                  .data()["url"],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3.h,
                                                  horizontal: 3.h),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    .data()["name"],
                                                style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.gray,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          showGeneralDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              barrierLabel:
                                                  MaterialLocalizations.of(
                                                          context)
                                                      .modalBarrierDismissLabel,
                                              barrierColor: Colors.black45,
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 200),
                                              pageBuilder:
                                                  (BuildContext buildContext,
                                                      Animation animation,
                                                      Animation
                                                          secondaryAnimation) {
                                                return Scaffold(
                                                  appBar: AppBar(
                                                    backgroundColor:
                                                        AppColors.green,
                                                    centerTitle: true,
                                                    title: Text(snapshot
                                                        .data!.docs[index]
                                                        .data()["name"]),
                                                  ),
                                                  body: Container(
                                                    width: 100.w,
                                                    height: 100.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5.h,
                                                            horizontal: 3.h),
                                                    child: Form(
                                                      key: _formKey,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Quantidade de material',
                                                              style: GoogleFonts.inter(
                                                                  fontSize:
                                                                      20.sp,
                                                                  color:
                                                                      AppColors
                                                                          .gray,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                              'Digite quanto de material você deseja vender',
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontSize: 12.sp,
                                                                color: AppColors
                                                                    .gray,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  quantidadeController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Ex: 2kg",
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              // The validator receives the text that the user has entered.
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Digite um número';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            Text(
                                                              'Horário',
                                                              style: GoogleFonts.inter(
                                                                  fontSize:
                                                                      20.sp,
                                                                  color:
                                                                      AppColors
                                                                          .gray,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                              'Selecione o horario de coleta',
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontSize: 12.sp,
                                                                color: AppColors
                                                                    .gray,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            DropdownButtonFormField(
                                                              value:
                                                                  dropdownValue,
                                                              icon: Icon(Icons
                                                                  .arrow_downward),
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Selecione um horário",
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              items: estados
                                                                  .map((String
                                                                      value) {
                                                                return new DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child:
                                                                      new Text(
                                                                          value),
                                                                );
                                                              }).toList(),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  dropdownValue =
                                                                      newValue;
                                                                });
                                                              },
                                                              validator:
                                                                  (dynamic
                                                                      value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Selecione um horário';
                                                                }
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            Text(
                                                              'Endereço',
                                                              style: GoogleFonts.inter(
                                                                  fontSize:
                                                                      20.sp,
                                                                  color:
                                                                      AppColors
                                                                          .gray,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                            Text(
                                                              'Digite um endereço para a coleta',
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontSize: 12.sp,
                                                                color: AppColors
                                                                    .gray,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  enderecoController,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Ex: Av. Paulista",
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              // The validator receives the text that the user has entered.
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Digite um endereço';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  dbRef.push().set({
                                                                    "quantidade":
                                                                        quantidadeController
                                                                            .text,
                                                                    "endereco":
                                                                        enderecoController
                                                                            .text,
                                                                    "horario":
                                                                        dropdownValue,
                                                                    "material": snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"],
                                                                    "user": user!
                                                                        .email!,
                                                                    "url": snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["url"],
                                                                  }).then((_) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text('Successfully Added')));
                                                                    enderecoController
                                                                        .clear();
                                                                    quantidadeController
                                                                        .clear();
                                                                  }).catchError(
                                                                      (onError) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text(onError)));
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                  'Submit'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        }),
                                  );
                                }),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Text("No data");
                    }
                    return CircularProgressIndicator();
                  },
                )
              : displayCachedList(),
        ),
      );
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getImages() {
    return fb.collection("guias").get();
  }

  ListView displayCachedList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: cachedResult!.docs.length,
        itemBuilder: (BuildContext context, int index) {
          print(cachedResult!.docs[index].data()["url"]);
          return ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text(
              cachedResult!.docs[index].data()["name"],
            ),
            leading: Image.network(cachedResult!.docs[index].data()["url"],
                fit: BoxFit.fill),
          );
        });
  }
}
