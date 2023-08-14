import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jan_g_shopy_userseller/seller/authScreens/seller_auth_screen.dart';
import 'package:jan_g_shopy_userseller/seller/brandsScreens/seller_home_screen.dart';
import 'package:jan_g_shopy_userseller/seller/sellerPreferences/seller_preferences.dart';



class SellerSplashScreen extends StatefulWidget {
  const SellerSplashScreen({Key? key}) : super(key: key);

  @override
  State<SellerSplashScreen> createState() => _SellerSplashScreenState();
}

class _SellerSplashScreenState extends State<SellerSplashScreen>
{
//the splash screen is there for 3 sec
  startTimer() async
  {
    // Read user info from preferences
    final sellerInfo = await RememberSellerPrefs.readSellerInfo();

    Timer(const Duration(seconds: 1), () async
    // if seller is already logged in send theme to homepage or to AuthScreen
        {
      if(sellerInfo !=null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> SellerHomeScreen()));
      }
      //if seller is not loogedin already
      else{
        Navigator.push(context, MaterialPageRoute(builder: (c)=> UserAuthScreen()));
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
                "jan-G sellers app",
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