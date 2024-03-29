import 'package:cicle/screens/HomePage/Vender/pedidos.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/database.dart';
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
  bool isRetrieved = false;
  final _addItemFormKey = GlobalKey<FormState>();
  final estados = ["9:00 - 10:00", "15:00 - 16:00", "19:00 - 20:00"];
  String? dropdownValue = '9:00 - 10:00';
  final quantidadeController = TextEditingController();
  final enderecoController = TextEditingController();
  final valorController = TextEditingController();
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
                                                      key: _addItemFormKey,
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
                                                              'Digite quanto de material você possui',
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
                                                              onChanged:
                                                                  (value) {
                                                                var valor =
                                                                    value;
                                                                var resultado;

                                                                if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"] ==
                                                                    'Plástico') {
                                                                  resultado =
                                                                      double.parse(
                                                                              valor) *
                                                                          0.80;

                                                                  valorController
                                                                          .text =
                                                                      "R\$ " +
                                                                          resultado
                                                                              .toStringAsFixed(1);
                                                                  ;
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"] ==
                                                                    'Bateria') {
                                                                  resultado =
                                                                      double.parse(
                                                                              valor) *
                                                                          0.40;

                                                                  valorController
                                                                          .text =
                                                                      "R\$ " +
                                                                          resultado
                                                                              .toStringAsFixed(1);
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"] ==
                                                                    'Metal') {
                                                                  resultado =
                                                                      double.parse(
                                                                              valor) *
                                                                          4.50;

                                                                  valorController
                                                                          .text =
                                                                      "R\$ " +
                                                                          resultado
                                                                              .toStringAsFixed(1);
                                                                  ;
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"] ==
                                                                    'Papel') {
                                                                  resultado =
                                                                      double.parse(
                                                                              valor) *
                                                                          4.50;

                                                                  valorController
                                                                          .text =
                                                                      "R\$ " +
                                                                          resultado
                                                                              .toStringAsFixed(1);
                                                                  ;
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"] ==
                                                                    'Vidro') {
                                                                  resultado =
                                                                      double.parse(
                                                                              valor) *
                                                                          0.37;

                                                                  valorController
                                                                          .text =
                                                                      "R\$ " +
                                                                          resultado
                                                                              .toStringAsFixed(1);
                                                                  ;
                                                                } else if (snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"] ==
                                                                    'Orgânico') {
                                                                  resultado =
                                                                      double.parse(
                                                                              valor) *
                                                                          0.37;

                                                                  valorController
                                                                          .text =
                                                                      "R\$ " +
                                                                          resultado
                                                                              .toStringAsFixed(1);
                                                                  ;
                                                                }
                                                                print(
                                                                    '$resultado');
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            Text(
                                                              'Valor estimado em reais',
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
                                                              readOnly: true,
                                                              controller:
                                                                  valorController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
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
                                                              height: 4.h,
                                                            ),
                                                            SizedBox(
                                                              width: 90.w,
                                                              height: 8.h,
                                                              child:
                                                                  ElevatedButton(
                                                                child: Text(
                                                                    'Cadastrar Pedido'),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary:
                                                                      AppColors
                                                                          .green,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15), // <-- Radius
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  fb
                                                                      .collection(
                                                                          "pedidos")
                                                                      .add({
                                                                    "quantidade":
                                                                        quantidadeController
                                                                            .text,
                                                                    "nome": user!
                                                                        .displayName!,
                                                                    "material": snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["name"],
                                                                    "url": snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()["url"],
                                                                    "email": user!
                                                                        .email!,
                                                                    "endereco":
                                                                        enderecoController
                                                                            .text,
                                                                    "horario":
                                                                        dropdownValue,
                                                                    "valor":
                                                                        valorController
                                                                            .text
                                                                  }).then((value) {
                                                                    print(value
                                                                        .id);
                                                                  });
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Pedidos()),
                                                                  );
                                                                },
                                                              ),
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

  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Deseja continuar aprendendo Flutter ?"),
    actions: [Text('Teste')],
  );

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
