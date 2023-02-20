import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:outq_new_app/Backend/models/owner_models.dart';
import 'package:outq_new_app/screens/owner/components/appbar/owner_appbar.dart';
import 'package:outq_new_app/screens/owner/home/owner_home.dart';
import 'package:outq_new_app/screens/owner/store/view/owner_view_store.dart';
import 'package:outq_new_app/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq_new_app/screens/shared/welcome_screen/welcome_screen.dart';
import 'package:outq_new_app/utils/color_constants.dart';
import 'package:outq_new_app/utils/constants.dart';
import 'package:outq_new_app/utils/sizes.dart';
import 'package:outq_new_app/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

Future save(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String ownerid = prefs.getString("ownerid") ?? "null";
  if (ownerid == "null") {
    Get.to(() => const Exithome());
  }

  print({shop.name, shop.type, shop.description, shop.location});
  final response = await http.post(
      Uri.parse(
        apidomain + "store/register/",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'name': shop.name,
        'location': shop.location,
        'id': ownerid,
        'description': shop.description,
        'type': shop.type,
        'img': shop.img,
        'start': shop.start,
        'end': shop.end,
        'employees': shop.employees,
      });

  if (response.statusCode == 201) {
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    print(jsonData["success"]);
    if (jsonData["success"]) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => OwnerExithome()),
          (Route<dynamic> route) => false);
    }
  }

}

class CreateStorePage extends StatefulWidget {
  const CreateStorePage({super.key});

  @override
  State<CreateStorePage> createState() => _CreateStorePageState();
}

class _CreateStorePageState extends State<CreateStorePage> {
  String _currentAddress = "";
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print(place.country);
      setState(() {
        _currentAddress =
            '${place.administrativeArea}, ${place.locality}, ${place.thoroughfare}, ${place.postalCode}';
      });
      print(_currentAddress);
      shop.location = _currentAddress;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: OwnerAppBarWithBack(
          title: "",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: tDefaultSize),
        color: Colors.white,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fill Your Shop Details',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    // Text(
                    //   'This data will be displayed in your account profile.',
                    //   textAlign: TextAlign.left,
                    //   style: Theme.of(context).textTheme.subtitle2,
                    // ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                    // Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                    // Text('ADDRESS: ${_currentAddress ?? ""}'),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _getCurrentPosition,
                      child: const Text("Get Current Location"),
                    )
                  ],
                ),
              ),
              CreateStoreForm(location: _currentAddress),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateStoreForm extends StatefulWidget {
  const CreateStoreForm({super.key, required this.location});
  final String location;

  @override
  State<CreateStoreForm> createState() => _CreateStoreFormState();
}

// TextEditingController nameController = TextEditingController(text: '');
// TextEditingController typeController = TextEditingController(text: '');
// TextEditingController descriptionController = TextEditingController(text: '');
// TextEditingController locationController = TextEditingController(text: '');

StoreModel shop = StoreModel('', '', '', '', '', '', '', ' ');

class _CreateStoreFormState extends State<CreateStoreForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  // controller: nameController,
                  onChanged: (val) {
                    shop.name = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Shop Name',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextFormField(
                  // controller: locationController,
                  initialValue: widget.location,
                  onChanged: (val) {
                    shop.location = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  // controller: descriptionController,
                  onChanged: (val) {
                    shop.description = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  // controller: descriptionController,
                  onChanged: (val) {
                    shop.img = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Image Link',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  // controller: descriptionController,
                  onChanged: (val) {
                    shop.start = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Store Start time',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  // controller: descriptionController,
                  onChanged: (val) {
                    shop.end = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Closing Time',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  // controller: descriptionController,
                  onChanged: (val) {
                    shop.employees = val;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'No. of employees ',
                    labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    // hintText: 'myshop..',
                  ),
                ),
              ),
              // Container(
              //   height: 80,
              //   padding: const EdgeInsets.symmetric(vertical: 12.0),
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(22),
              //   ),
              //   child: TextField(
              //     // controller: descriptionController,
              //     onChanged: (val) {
              //       shop.description = val;
              //     },
              //     decoration: const InputDecoration(
              //       labelText: 'Shop Opening Time',
              //       labelStyle: TextStyle(
              //         fontFamily: 'Montserrat',
              //         fontWeight: FontWeight.bold,
              //         color: Colors.grey,
              //       ),
              //       // hintText: 'myshop..',
              //     ),
              //   ),
              // ),
              addVerticalSpace(30),
              Container(
                width: 150,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      ColorConstants.bluegradient1,
                      ColorConstants.bluegradient2
                    ],
                    transform: const GradientRotation(9 * pi / 180),
                  ),
                ),
                child: Center(
                  child: TextButton(
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () {
                      shop.type = "null";
                      if (shop.name.isEmpty ||
                          shop.description.isEmpty ||
                          shop.type.isEmpty ||
                          shop.img.isEmpty ||
                          shop.start.isEmpty ||
                          shop.end.isEmpty ||
                          shop.location.isEmpty ||
                          shop.employees.isEmpty) {
                        Get.snackbar(
                          "Fill Every Field",
                          "Fill every fields to continue",
                          icon: const Icon(Icons.person, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(15),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                          isDismissible: true,
                          dismissDirection: DismissDirection.horizontal,
                          forwardAnimationCurve: Curves.bounceIn,
                        );
                      } else {
                        save(context);
                      }
                    },
                  ),
                ),
              ),
              addVerticalSpace(40)
            ],
          ),
        ));
  }
}
