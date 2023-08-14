import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jan_g_shopy_userseller/api_key.dart';
import 'package:jan_g_shopy_userseller/seller/splashScreen/seller_my_splash_screen.dart';
import 'package:jan_g_shopy_userseller/user/userPreferences/user_current_user.dart';
import 'package:jan_g_shopy_userseller/user/userPreferences/user_preferences.dart';

import '../userSellersScreens/users_home_screen.dart';
import '../userSplashScreen/user_splash_screen.dart';

class UserDrawer extends StatelessWidget {
  //to display the profile
  final CurrentUser _currentUserController = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    // Fetch the current user's data using getUserInfo() before building the drawer.
    _currentUserController.getUserInfo();

    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                // User profile image
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(API.userImage +
                        _currentUserController.user.user_profile),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                // User name
                Text(
                  _currentUserController.user.user_name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),

          // Body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // Home
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => UserHomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // My orders
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "My Orders",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> OrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // Not yet received orders
                ListTile(
                  leading: const Icon(
                    Icons.picture_in_picture_alt_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Not Yet Received Parcels",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> NotYetReceivedParcelsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // History
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "History",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // Search
                ListTile(
                  leading: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Search",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (c)=> SearchScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                // Logout
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    RememberUserPrefs.removeUserInfo();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> UserSplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                                ListTile(
                  leading: const Icon(
                    Icons.supervisor_account,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Become a Seller",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> SellerSplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
