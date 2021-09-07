import 'package:cicle/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Pedidos extends StatefulWidget {
  const Pedidos({Key? key}) : super(key: key);

  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  final dbRef = FirebaseDatabase.instance.reference().child("pedidos");
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<dynamic, dynamic>> lists = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pedidos'),
        backgroundColor: AppColors.green,
      ),
      body: FutureBuilder(
          future: dbRef.orderByChild("user").equalTo(user!.email!).once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data!.value;
              values.forEach((key, values) {
                lists.add(values);
              });
              return new ListView.builder(
                  shrinkWrap: true,
                  itemCount: lists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(lists[index]["quantidade"]),
                      subtitle: Text(lists[index]["endereco"]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    );
                  });
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
