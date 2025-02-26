import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq_new_app/screens/user/components/appbar/user_appbar.dart';
import 'package:outq_new_app/screens/user/home/user_home.dart';
import 'package:outq_new_app/utils/constants.dart';
import 'package:outq_new_app/utils/widget_functions.dart';
import 'package:http/http.dart' as http;

Future cancelBooking(BuildContext context) async {
  dynamic argumentData = Get.arguments;
  // print(argumentData[3]);
  var response = await http.get(
    Uri.parse('${apidomain}booking/cancel/${argumentData[3]}'),
  );
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (BuildContext context) => const UserHomePage()),
      (Route<dynamic> route) => false);
  // Get.to(() => const UserHomePage());
}

class UserSingleAppoinmentInfoPage extends StatefulWidget {
  const UserSingleAppoinmentInfoPage({super.key});

  @override
  State<UserSingleAppoinmentInfoPage> createState() =>
      _UserSingleAppoinmentInfoPageState();
}

class _UserSingleAppoinmentInfoPageState
    extends State<UserSingleAppoinmentInfoPage> {
  dynamic argumentData = Get.arguments;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: UserAppBarWithBack(
            title: "",
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1562322140-8baeececf3df?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=869&q=80"),
                      ),
                    ),
                  ),
                  addVerticalSpace(20),
                  Text(
                    argumentData[4],
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    argumentData[5],
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  addVerticalSpace(30),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "10.00 AM",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "100 ₹",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Hair Cutting",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Store",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              // width: 100,
                              // height: 25,
                              // color: Colors.blue[700],
                              child: Center(
                                  child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Mens Fashion",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(30),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: Container(
                    //     width: 300,
                    //     color: Colors.blue,
                    //     child: TextButton(
                    //       onPressed: () {
                    //         // Add your onPressed action here
                    //       },
                    //       child: Text(
                    //         'Get Direction',
                    //         style: GoogleFonts.poppins(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 16.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    addVerticalSpace(10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 300,
                        color: Colors.red,
                        child: TextButton(
                          onPressed: () {
                            cancelBooking(context);
                          },
                          child: Text(
                            'Cancel Appoinment',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
