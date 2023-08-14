import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jan_g_shopy_userseller/seller/brandsScreens/seller_home_screen.dart';
import 'package:jan_g_shopy_userseller/seller/earningsScreen/seller_earnings_screen.dart';
import 'package:jan_g_shopy_userseller/seller/historyScreen/seller_history_screen.dart';
import 'package:jan_g_shopy_userseller/seller/ordersScreens/seller_orders_screen.dart';
import 'package:jan_g_shopy_userseller/seller/sellerPreferences/current_seller.dart';
import 'package:jan_g_shopy_userseller/seller/sellerPreferences/seller_preferences.dart';
import 'package:jan_g_shopy_userseller/seller/shiftedParcelsScreen/seller_shifted_parcels_screen.dart';
import '../../api_key.dart';
import '../../user/userSplashScreen/user_splash_screen.dart';
import '../splashScreen/seller_my_splash_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final CurrentSeller _currentSellerController = Get.put(CurrentSeller());

  @override
  void initState() {
    super.initState();
    _currentSellerController.getSellerInfo();
  }

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                //user profile image
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(API.sellerImage +
                        _currentSellerController.seller.seller_profile),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                //user name
                Text(
                  _currentSellerController.seller.seller_name,
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

          //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //home
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
                        MaterialPageRoute(builder: (c) => SellerHomeScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //earnings
                ListTile(
                  leading: const Icon(
                    Icons.currency_rupee,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Earnings",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => EarningsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //my orders
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "New Orders",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => OrdersScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //Shifted Parcels
                ListTile(
                  leading: const Icon(
                    Icons.picture_in_picture_alt_rounded,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Shifted Parcels",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ShiftedParcelsScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //history
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => HistoryScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //logout
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
                    RememberSellerPrefs.removeSellerInfo();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => SellerSplashScreen()));
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
                    "Be a User",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Get.to(const UserSplashScreen());
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
