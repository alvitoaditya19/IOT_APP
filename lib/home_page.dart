import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fb = FirebaseDatabase.instance;
  bool select1 = false;
  String name = "1";
  String name1 = "0";
  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child("DSC");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.snapshot.value != null) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            'Sistem IOT',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: Color(0xff0D2841),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Suhu',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Color(0xff0D2841),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.snapshot.value["suhu"]
                                      .toString()} °C',
                                  style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    color: Color(0xff0D2841),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Intensitas Cahaya',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Color(0xff0D2841),
                                  ),
                                ),
                                Text(
                                  '${snapshot.data!.snapshot.value["ldr"]
                                      .toString()} Luxx',
                                  style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    color: Color(0xff0D2841),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            select1 = !select1;
                            print('Button Selected = $select1'); //log
                          });
                          select1
                              ? ref.child("lampu1").set(name1)
                              : ref.child("lampu1").set(name);
                          print('Tombol ON/OFF Ditekan');
                        },
                        child: Container(
                          width: 150,
                          height: 150.0,
                          decoration: select1
                              ? BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xff22A7F0).withOpacity(0.26),
                                      Color(0xffC4FAF8).withOpacity(0.23)
                                    ],
                                    radius: 1.8,
                                    center: Alignment(0, 0),
                                  ),
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(27),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 3),
                                      blurRadius: 3,
                                      color: const Color(0xff000000)
                                          .withOpacity(0.90),
                                    )
                                  ],
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blue,
                                ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: select1
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/icon_lamp2.png",
                                          width: 120.0,
                                          height: 70,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Lamp 1 On",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/icon_lamp1.png",
                                          width: 70.0,
                                          height: 70,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          "Lamp 1 Off",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                      return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Future<void> readData() async {
    fb.ref().child("DSC").child("ldr").once().then((DatabaseEvent snapshot) {
      print(snapshot.snapshot);
    });
  }
}
