import 'package:cicle/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Cards extends StatefulWidget {
  Cards({Key? key}) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 1,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                  child: Column(
                                    children: [
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
                                            body: Container(
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 40.h,
                                                        width: 100.w,
                                                        child: Image.network(
                                                          snapshot
                                                              .data!.docs[index]
                                                              .data()["url"],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5.h,
                                                                horizontal:
                                                                    3.h),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: IconButton(
                                                            iconSize: 8.w,
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                              Icons.arrow_back,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 100.h,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0.h,
                                                              horizontal: 3.h),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 4.h,
                                                            ),
                                                            Center(
                                                              child: Container(
                                                                height: 2.h,
                                                                width: 20.w,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xffD0DBEA),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 3.h,
                                                            ),
                                                            Text(
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .data()["name"],
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .gray,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Text(
                                                              snapshot.data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  "texto"],
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: AppColors
                                                                    .gray,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
    return fb.collection("cards").get();
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
