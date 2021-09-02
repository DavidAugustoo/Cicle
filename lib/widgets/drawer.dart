// import 'package:cicle/screens/home.dart';
// import 'package:cicle/themes/colors.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class NavigateDrawerState extends State<NavigateDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountEmail: FutureBuilder(
//                 future: FirebaseDatabase.instance
//                     .reference()
//                     .child("Users")
//                     .child(widget.uid!)
//                     .once(),
//                 builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(snapshot.data!.value['email']);
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 }),
//             accountName: FutureBuilder(
//                 future: FirebaseDatabase.instance
//                     .reference()
//                     .child("Users")
//                     .child(widget.uid!)
//                     .once(),
//                 builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(snapshot.data!.value['name']);
//                   } else {
//                     return CircularProgressIndicator();
//                   }
//                 }),
//             decoration: BoxDecoration(
//               color: AppColors.green,
//             ),
//           ),
//           ListTile(
//             leading: new IconButton(
//               icon: new Icon(Icons.home, color: Colors.black),
//               onPressed: () => null,
//             ),
//             title: Text('Home'),
//             onTap: () {
//               print(widget.uid);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
//               );
//             },
//           ),
//           ElevatedButton(onPressed: () {}, child: Text('Excluir conta')),
//           ListTile(
//             leading: new IconButton(
//               icon: new Icon(Icons.settings, color: Colors.black),
//               onPressed: () => null,
//             ),
//             title: Text('Settings'),
//             onTap: () {
//               print(widget.uid);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
