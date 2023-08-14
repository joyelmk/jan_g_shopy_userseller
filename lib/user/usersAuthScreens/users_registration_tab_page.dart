import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jan_g_shopy_userseller/api_key.dart';
import 'package:jan_g_shopy_userseller/seller/splashScreen/seller_my_splash_screen.dart';
import 'package:jan_g_shopy_userseller/user/userPreferences/user_preferences.dart';
import 'package:jan_g_shopy_userseller/user/userWidgets/user_loading_dialog.dart';

import '../userModels/userUsers.dart';
import '../userSellersScreens/users_home_screen.dart';
import '../userWidgets/custom_text_field.dart';

class RegistrationTabPage extends StatefulWidget {
  const RegistrationTabPage({Key? key}) : super(key: key);

  @override
  _RegistrationTabPageState createState() => _RegistrationTabPageState();
}

class _RegistrationTabPageState extends State<RegistrationTabPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  XFile? imageXFile;
  String? imagename;
  String? imagedata;
  File? imagepath;

  final ImagePicker _picker = ImagePicker();

  String usersImageUrl = "";

  // The ImagePicker
  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
      imagename = imageXFile?.path.split('/').last;
      imagepath = File(imageXFile!.path);
      imagedata = base64Encode(imagepath!.readAsBytesSync());
      // print("hello:" + imagedata.toString());
    });
  }

  //this function is send the image to the php code and it will upload to a folder with unique name
  Future<void> uploadImage() async {
    try {
      var res = await http.post(
        Uri.parse(API.profileImage),
        body: {"data": imagedata, "name": imagename},
      );
      var response = jsonDecode(res.body);

      if (response["success"] == true) {
        //see if is sending response
        //print("Uploaded Image Path: ${response["path"]}");
        usersImageUrl = response["path"]; // Update the sellerImageUrl variable
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print(e);
    }
  }

  //this function is get current location
  //the form validation
  Future<void> formValidation() async {
    if (imageXFile == null) {
      Fluttertoast.showToast(msg: "Please select an image.");
    } else {
      if (passwordTextEditingController.text ==
          confirmPasswordTextEditingController.text) {
        if (confirmPasswordTextEditingController.text.isNotEmpty &&
            emailTextEditingController.text.isNotEmpty &&
            nameTextEditingController.text.isNotEmpty) {
          //if all the form is valid it will call this function
          authenticateSeller();
        } else {
          Fluttertoast.showToast(
              msg: "Please write the complete required info for Registration.");
        }
      } else {
        Fluttertoast.showToast(msg: "Password do not match.");
      }
    }
  }

  //this function send the sellers email to the php code and check is it all ready registered or not
  void authenticateSeller() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: {
          'user_email': emailTextEditingController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        //from flutter app the connection with api to server - success
        var resBodyOfValidateEmail = jsonDecode(res.body);
        //if email is not registered it send back response ['emailFound'] ==true
        if (resBodyOfValidateEmail['emailFound'] == true) {
          Fluttertoast.showToast(
              msg: "Email is already in someone else use. Try another email.");
        } else {
          showDialog(
            context: context,
            builder: (c) {
              return UserLoadingDialogWidget(
                message: "Registering Account",
              );
            },
          );
          //if everything is successful then it call uploadImage function
          //start uploading image
          await uploadImage(); // Upload the image

          //registering the seller to database my Sql
          registerAndSaveUserRecord();
        }
      } else {
        print("failed to register");
      }
    } catch (e) {
      print("failed to register............");
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //so this function will save the data in mysql
  registerAndSaveUserRecord() async {
    //here it send the data to the users_user.dart in sellers_madel and change
    //to the json format Go check users_user.dart

    User userModel = User(
      1,
      nameTextEditingController.text.trim(),
      emailTextEditingController.text.trim(),
      confirmPasswordTextEditingController.text.trim(),
      usersImageUrl,
    );
    try {
      //here the data is sent to the php file
      var res = await http.post(
        //Api is class were its in api_sellers_app/users_api_connection.dart
        Uri.parse(API.register),
        body: userModel.toJson(),
      );
      if (res.statusCode == 200) {
        //from flutter app the connection with api to server - success
        var resBodyOfSignUp = jsonDecode(res.body);
        if (resBodyOfSignUp['success'] == true) {
          //also get user data from php file as a response
          //its in json format so decode using User class and save data in userInfo variable
          User userInfo = User.fromJson(resBodyOfSignUp['userData']);
          //save userInfo to local Storage using Shared Prefrences inside /sellersPreferences/users_preferences.dart
          await RememberUserPrefs.storeUserInfo(userInfo);

          //everything go good the user will be sent to SellersHomePage
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
        } else {
          Fluttertoast.showToast(msg: "Error Occurred, Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXFile == null
                    ? null
                    : FileImage(File(imageXFile!.path)),
                child: imageXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //name
                  UserCustomTextField(
                    textEditingController: nameTextEditingController,
                    iconData: Icons.person,
                    hintText: "Name",
                    isObsecre: false,
                    enabled: true,
                  ),

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

                  //confirm pass
                  UserCustomTextField(
                    textEditingController: confirmPasswordTextEditingController,
                    iconData: Icons.lock,
                    hintText: "Confirm Password",
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
                    height: 20,
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
                  formValidation();
                },
                child: const Text(
                  "Sign Up",
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
      ),
    );
  }
}
