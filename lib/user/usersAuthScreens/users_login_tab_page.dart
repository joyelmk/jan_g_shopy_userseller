import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:jan_g_shopy_userseller/api_key.dart';
import 'package:jan_g_shopy_userseller/seller/splashScreen/seller_my_splash_screen.dart';
import 'dart:convert';
import 'package:jan_g_shopy_userseller/user/userPreferences/user_preferences.dart';

import '../userModels/userUsers.dart';
import '../userSellersScreens/users_home_screen.dart';
import '../userWidgets/custom_text_field.dart';
import '../userWidgets/user_loading_dialog.dart';

class LoginTabPage extends StatefulWidget {
  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
      var formKey = GlobalKey<FormState>();
  var emailTextEditingController = TextEditingController();
  var passwordTextEditingController = TextEditingController();
  var isObsecure = true.obs;

  validateForm() {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      // Allow user to login
      loginNow();
    } else {
      Fluttertoast.showToast(msg: "Please provide email and password.");
    }
  }

  loginNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return UserLoadingDialogWidget(
          message: "Checking credentials",
        );
      },
    );
    try
    {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailTextEditingController.text.trim(),
          "user_password": passwordTextEditingController.text.trim(),
        },
      );

      if(res.statusCode == 200) //from flutter app the connection with api to server - success
      {
        var resBodyOfLogin = jsonDecode(res.body);
        if(resBodyOfLogin['success'] == true)
        {
          Fluttertoast.showToast(msg: "you are logged-in Successfully.");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          //save userInfo to local Storage using Shared Prefrences
          await RememberUserPrefs.storeUserInfo(userInfo);

          Future.delayed(Duration(milliseconds: 2000), ()
          {
            Get.to(UserHomeScreen());
          });
        }
        else
        {
          Fluttertoast.showToast(msg: "Incorrect Credentials.\nPlease write correct password or email and Try Again.");
        }
      }
      else
      {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    }
    catch(errorMsg)
    {
      print("Error :: " + errorMsg.toString());
    }

  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "images/login.png",
              height: MediaQuery.of(context).size.height * 0.40,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                //email
                UserCustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: "Email",
                  isObsecre: false,
                  enabled: true,
                ),

                //pass
                UserCustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: "Password",
                  isObsecre: true,
                  enabled: true,

                ),

                TextButton(
                  onPressed: ()
                  {
                    Get.to(const SellerSplashScreen());
                  },
                  child: const Text(
                    "Are you an Seller? Click Here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              onPressed: () {
                validateForm();
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
