import 'package:cicle/screens/HomePage/HomePage.dart';
import 'package:cicle/themes/colors.dart';
import 'package:cicle/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

class Guias extends StatefulWidget {
  Guias({Key? key}) : super(key: key);

  @override
  _GuiasState createState() => _GuiasState();
}

class _GuiasState extends State<Guias> {
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  bool isLoading = false;
  bool isRetrieved = false;
  QuerySnapshot<Map<String, dynamic>>? cachedResult;

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
                      return ListView.builder(
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
                                        height: 4.h,
                                      ),
                                      Image.network(
                                        snapshot.data!.docs[index]
                                            .data()["url"],
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.h, horizontal: 3.h),
                                        child: Text(
                                          snapshot.data!.docs[index]
                                              .data()["name"],
                                          style: GoogleFonts.inter(
                                            fontSize: 13.sp,
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
                                            MaterialLocalizations.of(context)
                                                .modalBarrierDismissLabel,
                                        barrierColor: Colors.black45,
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        pageBuilder: (BuildContext buildContext,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return Scaffold(
                                            body: CustomScrollView(
                                              slivers: [
                                                SliverAppBar(
                                                  backgroundColor:
                                                      AppColors.green,
                                                  expandedHeight: 250,
                                                  pinned: true,
                                                  flexibleSpace:
                                                      FlexibleSpaceBar(
                                                    centerTitle: true,
                                                    title: Text(
                                                      snapshot.data!.docs[index]
                                                          .data()["name"],
                                                    ),
                                                  ),
                                                ),
                                                SliverFillRemaining(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0.h,
                                                            horizontal: 5.h),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(height: 5.h),
                                                        Text(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .data()["texto"],
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                AppColors.gray,
                                                          ),
                                                          textAlign:
                                                              TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  }),
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
