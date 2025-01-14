import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq_new_app/Backend/api/owner_api.dart';
import 'package:outq_new_app/screens/owner/analytics/owner_analytics.dart';
import 'package:outq_new_app/screens/owner/booking/view-booking.dart';
import 'package:outq_new_app/screens/owner/components/appbar/owner_bar_main.dart';
import 'package:outq_new_app/screens/owner/components/drawer/owner_drawer.dart';
import 'package:outq_new_app/screens/owner/history/appoinment_history.dart';
import 'package:outq_new_app/screens/owner/service/view/owner_view_service.dart';
import 'package:get/get.dart';
import 'package:outq_new_app/screens/owner/store/view/owner_view_store.dart';
import 'package:outq_new_app/utils/sizes.dart';

class OwnerHomePage extends StatefulWidget {
  OwnerHomePage({super.key, required this.currentIndex});
  int currentIndex;

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  List tabScreens = const [
    OwnerHomeScreen(),
    OwnerViewStorePage(),
    OwnerViewServicePage(),
    OwnerStoreAnalyticsPage(),
    OwnerAppoinmentHistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: OwnerAppBar(
          title: "",
        ),
      ),
      drawer: const OwnerDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: (index) => setState(() => widget.currentIndex = index),
          unselectedLabelStyle: TextStyle(
            color: Colors.blueGrey[50],
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.blue,
          ),
          selectedLabelStyle: const TextStyle(
            color: Colors.blue,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.blueGrey[200],
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 25,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded,size: 20),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store,size: 20),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.design_services_outlined,size: 20),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics,size: 20,),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history,size: 20),
              label: 'History',
            ),
          ]),
      body: tabScreens.elementAt(widget.currentIndex),
    );
  }
}

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});
  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  List list = [
    "Flutter",
    "React",
    "Ionic",
    "Xamarin",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
      color: Colors.white,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Expanded(
          //   flex: 2,
          //   child: GFSearchBar(
          //     searchList: list,
          //     searchQueryBuilder: (query, list) {
          //       return list
          //           .where((item) =>
          //               item.toLowerCase().contains(query.toLowerCase()))
          //           .toList();
          //     },
          //     overlaySearchListItemBuilder: (item) {
          //       return Container(
          //         padding: const EdgeInsets.all(8),
          //         child: Text(
          //           item,
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       );
          //     },
          //     onItemSelected: (item) {
          //       setState(() {
          //         // print('$item');
          //       });
          //     },
          //   ),
          // ),
          FutureBuilder(
            future: getOwnerStore(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                ));
              } else {
                if (snapshot.data.length == 0) {
                  return const Center(
                      child: Text(
                    'No Content is available right now.',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ));
                } else {
                  return Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, i) {
                            return Container(
                              height: 150,
                              padding: const EdgeInsets.only(right: 60),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[i].name,
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    snapshot.data[i].description,
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            );
                          }));
                }
              }
            },
          ),
          FutureBuilder(
            future: getStoreServiceBooking(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: SpinKitCircle(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                ));
              } else {
                if (snapshot.data.length == 0) {
                  return const Expanded(
                    flex: 6,
                    child: Center(
                        child: Text(
                      'No Booking is available right now.',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    )),
                  );
                } else {
                  return Expanded(
                    flex: 6,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () => Get.to(
                              () => const OwnerAppoinmentInfoPage(),
                              arguments: [
                                snapshot.data[i].start,
                                snapshot.data[i].storeid,
                                snapshot.data[i].serviceid,
                                snapshot.data[i].servicename,
                                snapshot.data[i].storename,
                                snapshot.data[i].price,
                                snapshot.data[i].bookingid,
                                snapshot.data[i].username,
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: SizedBox(
                                    height: 60,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image(
                                            image: NetworkImage(
                                                snapshot.data[i].img))),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[i].servicename,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                        Text(
                                          snapshot.data[i].username,
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2,
                                        ),
                                        // Text('₹7',
                                        //     textAlign: TextAlign.left,
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .headline5),
                                      ]),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 100,
                                      height: 25,
                                      color: Colors.blue[700],
                                      child: Center(
                                          child: TextButton(
                                        onPressed: () {
                                          // Get.to(() => const ShopBookingPage(),
                                          //     arguments: [
                                          //       snapshot.data[i].id,
                                          //       snapshot.data[i].storeid,
                                          //       // snapshot.data[i].price,
                                          //       snapshot.data[i].name,
                                          //     ]);
                                        },
                                        child: Text(
                                          snapshot.data[i].start,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                          ),
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
