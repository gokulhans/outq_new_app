import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outq_new_app/screens/owner/auth/signup/signup.dart';
import 'package:outq_new_app/screens/user/auth/login/login.dart';
import 'package:outq_new_app/screens/user/auth/signup/signup.dart';
import 'package:outq_new_app/utils/image_strings.dart';
import 'package:outq_new_app/utils/text_strings.dart';
import 'package:outq_new_app/utils/sizes.dart';
import 'package:outq_new_app/utils/widget_functions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
                image: const AssetImage(tWelcomeTopImage),
                height: height * 0.6),
            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    tWelcomeSubTitle,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () => Get.to(()=> const UserLoginPage()),
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      padding:
                          const EdgeInsets.symmetric(vertical: tButtonHeight)),
                  child: const Text(tLogin),
                )),
                addHorizontalSpace(10),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => Get.to(()=> const UserSignUpPage()),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      padding:
                          const EdgeInsets.symmetric(vertical: tButtonHeight)),
                  child: const Text(tSignUp),
                ))
              ],
            ),
            TextButton(
                onPressed: () => Get.to(()=> const OwnerSignUpPage()),
                child: const Center(
                  child: Text(tOwnerQuestion),
                ))
          ],
        ),
      ),
    );
  }
}