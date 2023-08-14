import 'package:flutter/material.dart';
import 'package:jan_g_shopy_userseller/seller/widgets/seller_text_delegate_header_widget.dart';
import '../widgets/seller_my_drawer.dart';


class SellerHomeScreen extends StatefulWidget
{
  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}


class _SellerHomeScreenState extends State<SellerHomeScreen>
{
  getSellerEarningsFromDatabase()
  {
    // FirebaseFirestore.instance
    //     .collection("sellers")
    //     .doc(sharedPreferences!.getString("uid"))
    //     .get()
    //     .then((dataSnapShot)
    // {
    //   previousEarning = dataSnapShot.data()!["earnings"].toString();
    // }).whenComplete(()
    // {
    //   restrictBlockedSellersFromUsingSellersApp();
    // });
  }

  restrictBlockedSellersFromUsingSellersApp() async
  {
    // await FirebaseFirestore.instance
    //     .collection("sellers")
    //     .doc(sharedPreferences!.getString("uid"))
    //     .get().then((snapshot)
    // {
    //   if(snapshot.data()!["status"] != "approved")
    //   {
    //     showReusableSnackBar(context, "you are blocked by admin.");
    //     showReusableSnackBar(context, "contact admin: admin2@jan-G-shopy.com");

    //     FirebaseAuth.instance.signOut();
    //     Navigator.push(context, MaterialPageRoute(builder: (c)=> SellerSplashScreen()));
    //   }
    // });
  }

  @override
  void initState()
  {
    super.initState();

    // PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
    // pushNotificationsSystem.whenNotificationReceived(context);
    // pushNotificationsSystem.generateDeviceRecognitionToken();

    getSellerEarningsFromDatabase();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      drawer: MyDrawer(),
    appBar: AppBar(
    flexibleSpace: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.black, Colors.pink.shade400],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    ),
    ),
    ),

    title: Row(
    children:<Widget>[ const Text(
  "jan-G  shopy",
  style: TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontStyle: FontStyle.italic,

  fontWeight: FontWeight.bold,
  ),
  ),
  ],
  ),
    ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(title: "My Brands"),
          ),

          //1. write query
          //2  model
          //3. ui design widget

          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection("sellers")
          //       .doc(sharedPreferences!.getString("uid"))
          //       .collection("brands")
          //       .orderBy("publishedDate", descending: true)
          //       .snapshots(),
          //   builder: (context, AsyncSnapshot dataSnapshot)
          //   {
          //     if(dataSnapshot.hasData) //if brands exists
          //     {
          //       //display brands
          //       return SliverStaggeredGrid.countBuilder(
          //           crossAxisCount: 1,
          //           staggeredTileBuilder: (c)=> const StaggeredTile.fit(1),
          //           itemBuilder: (context, index)
          //           {
          //             Brands brandsModel = Brands.fromJson(
          //               dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
          //             );

          //             return BrandsUiDesignWidget(
          //               model: brandsModel,
          //               context: context,
          //             );
          //           },
          //           itemCount: dataSnapshot.data.docs.length,
          //       );
          //     }
          //     else //if brands NOT exists
          //     {
          //       return const SliverToBoxAdapter(
          //         child: Center(
          //           child: Text(
          //             "No brands exists",
          //           ),
          //         ),
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
