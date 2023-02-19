import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq_new_app/screens/shared/exit_pop/exit_pop_up.dart';
import 'package:outq_new_app/screens/shared/welcome_screen/welcome_screen.dart';

class UserForgotPsdPage extends StatelessWidget {
  const UserForgotPsdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "User Forgot Psd",
            style: Theme.of(context).textTheme.headline4,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => const Exithome());
              },
              child: const Text("Welcome"))
        ],
      )),
    );
  }
}
