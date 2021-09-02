import 'package:cicle/services/firebase_service.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                FirebaseService service = new FirebaseService();
                await service.signOutFromGoogle();
                Navigator.pushReplacementNamed(
                    context, Constants.signInNavigate);
              },
            )
          ],
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoURL!),
                radius: 20,
              ),
              SizedBox(height: 2.h),
              Text(
                user!.displayName!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Text(user!.email!),
            ],
          ),
        ),
      );
    });
  }
}
