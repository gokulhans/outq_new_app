import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq_new_app/Backend/models/owner_models.dart';
import 'package:outq_new_app/screens/owner/auth/login/login.dart';
import 'package:outq_new_app/screens/owner/home/owner_home.dart';
import 'package:outq_new_app/screens/owner/store/create/create_store.dart';
import 'package:outq_new_app/utils/constants.dart';
import 'package:outq_new_app/utils/text_strings.dart';
import 'package:outq_new_app/utils/color_constants.dart';
import 'package:outq_new_app/utils/sizes.dart';
import 'package:outq_new_app/utils/widget_functions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OwnerLoginPage extends StatefulWidget {
  const OwnerLoginPage({super.key});

  @override
  State<OwnerLoginPage> createState() => _OwnerLoginPageState();
}

TextEditingController nameController = TextEditingController(text: '');
TextEditingController emailController = TextEditingController(text: '');
TextEditingController pswdController = TextEditingController(text: '');

OwnerLoginModel owners = OwnerLoginModel('', '');

class _OwnerLoginPageState extends State<OwnerLoginPage> {
  Future save() async {
    print({owners.email, owners.pswd});
    final response = await http.post(
        Uri.parse(
          "${apidomain}auth/owner/login",
        ),
        headers: <String, String>{
          'Context-Type': 'application/json; charset=UTF-8',
        },
        body: <String, String>{
          'email': owners.email,
          'pswd': owners.pswd,
        });

    var jsonData = jsonDecode(response.body);
    var str = jsonData[0]["id"];

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("ownerid", str);
    // Get.to(() => {OwnerHomePage(currentIndex:0)});
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) => OwnerHomePage(currentIndex: 0,)),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Center(
                      child: Text(
                        tOwnerLogin,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        onChanged: (val) {
                          owners.email = val;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            // hintText: 'EMAIL',
                            // hintStyle: ,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: pswdController,
                        onChanged: (val) {
                          owners.pswd = val;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                      ),
                      const SizedBox(height: 50.0),
                      // ignore: sized_box_for_whitespace
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.blueAccent,
                            color: ColorConstants.blue,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: TextButton(
                                  child: const Text(
                                    tLogin,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    print("saved");
                                    save();
                                  },
                                ),
                              ),
                            ),
                          )),
                      addVerticalSpace(20),
                    ],
                  )),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    tOwnerLoginQuestion,
                  ),
                  TextButton(
                    child: Text(tOwnerLogin,
                        style: TextStyle(
                          color: ColorConstants.blue,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        )),
                    onPressed: () => Get.to(() => const OwnerLoginPage()),
                  )
                ],
              )
            ]),
      ),
    ));
  }
}
