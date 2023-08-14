import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jan_g_shopy_userseller/user/userPreferences/user_preferences.dart';

import '../../seller/authScreens/seller_auth_screen.dart';
import '../userSellersScreens/users_home_screen.dart';

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  State<UserSplashScreen> createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
//the splash screen is there for 3 sec
  startTimer() async {
    // Read user info from preferences
    final userInfo = await RememberUserPrefs.readUserInfo();

    Timer(const Duration(seconds: 1), () async
        // if seller is already logged in send theme to homepage or to AuthScreen
        {
      if (userInfo != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => UserHomeScreen()));
      }
      //if seller is not loogedin already
      else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => UserAuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.blue,
            Colors.purple,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Center(
          child: Column(
            //to move image center
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset("images/splash.png"),
              ),
              // to add space between text widget and image
              const SizedBox(
                height: 10,
              ),
              //To display shop name or user name
              const Text(
                "jan-G Users app",
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 3,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
