import 'package:cicle/screens/HomePage/Vender/pedidos.dart';
import 'package:cicle/screens/HomePage/Vender/vender.dart';
import 'package:cicle/services/firebase_service.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: AppBar(
            title: Text('Perfil'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            elevation: 0,
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
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.blue),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 5,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  color: Colors.white,
                  height: 37.h,
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: 25.w,
                          height: 25.h,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user!.photoURL!),
                            radius: 20,
                          ),
                        ),
                        Text(
                          user!.displayName!,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gray,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          user!.email!,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              width: 90.w,
              height: 8.h,
              child: ElevatedButton(
                child: Text('Meus Pedidos'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // <-- Radius
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pedidos()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 3.h,
            )
          ],
        ),
      );
    });
  }
}
