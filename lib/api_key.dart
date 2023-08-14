
class API {
  static const hostConnect = "http://192.168.0.109/Learning/jan_g_shopy_userseller/shop_zone_api/";


  //user
  static const hostConnectUser = "$hostConnect/user";

  static const validateEmail = "$hostConnectUser/validation_email.php";
  static const register = "$hostConnectUser/register.php";
  static const profileImage = "$hostConnectUser/uploadImage.php";
  static const login = "$hostConnectUser/login.php";
  static const userImage = "$hostConnectUser/";
  static const userCart = "$hostConnectUser/userCart/order.php";


////////////////////////////////////////////////////////////////////////////////



  // seller api

  static const hostConnectSeller = "$hostConnect/seller";

  static const validateSellerEmail = "$hostConnectSeller/validation_email.php";
  static const registerSeller = "$hostConnectSeller/register.php";
  static const profileImageSeller = "$hostConnectSeller/uploadImage.php";
  static const loginSeller = "$hostConnectSeller/login.php";
  static const sellerImage = "$hostConnectSeller/";
  // Add them according to your specific API structure.
}
