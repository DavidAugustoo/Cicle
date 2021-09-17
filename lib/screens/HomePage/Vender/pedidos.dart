import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({Key? key}) : super(key: key);

  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  bool isRetrieved = false;
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
        appBar: AppBar(
          title: Text('Pedidos'),
          backgroundColor: AppColors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: !isRetrieved
              ? FutureBuilder(
                  future: getDocs(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      isRetrieved = true;
                      cachedResult = snapshot.data;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            print(ds.id);
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  title: Text(
                                      snapshot.data!.docs[index]
                                              .data()["material"] +
                                          " - " +
                                          snapshot.data!.docs[index]
                                              .data()["quantidade"] +
                                          "kg",
                                      style: GoogleFonts.inter(
                                        color: Color(0xff5C5C5C),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  leading: Image.network(
                                    snapshot.data!.docs[index].data()["url"],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            .data()["nome"],
                                        style: GoogleFonts.inter(),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            .data()["valor"],
                                        style: GoogleFonts.inter(),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            .data()["horario"],
                                        style: GoogleFonts.inter(),
                                      ),
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            .data()["endereco"],
                                        style: GoogleFonts.inter(),
                                      )
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog<void>(
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
                                              backgroundColor: Colors.red,
                                              maxRadius: 35.0,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Atenção',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.gray,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Você tem certeza que deseja remover o pedido?',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.gray,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'A ação não poderá ser desfeita',
                                                  style: TextStyle(
                                                    color: AppColors.gray,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                      color: AppColors.gray),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  'Remover',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('pedidos')
                                                      .doc(ds.id)
                                                      .delete();
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          Constants
                                                              .homeNavigate,
                                                          (route) => false);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
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

  Future<QuerySnapshot<Map<String, dynamic>>> getDocs() {
    return fb
        .collection("pedidos")
        .where("email", isEqualTo: user!.email!)
        .get();
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
              cachedResult!.docs[index].data()["quantidade"],
            ),
            leading: Image.network(cachedResult!.docs[index].data()["url"],
                fit: BoxFit.fill),
          );
        });
  }
}
