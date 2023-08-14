
import 'package:get/get.dart';
import 'package:jan_g_shopy_userseller/user/userPreferences/user_preferences.dart';
import '../userModels/userUsers.dart';

class CurrentUser extends GetxController
{
  Rx<User> _currentUser = User(0,'','','','').obs;

  User get user => _currentUser.value;


  getUserInfo() async
  {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}


