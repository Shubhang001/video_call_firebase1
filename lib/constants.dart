// Flutter imports:
import 'package:flutter/material.dart';
import 'package:video_call_firebase1/homepage.dart';
import 'package:video_call_firebase1/login_screen.dart';

// Project imports:

class PageRouteNames {
  static const String login = '/login';
  static const String home = '/home_page';
}

const TextStyle textStyle = TextStyle(
  color: Colors.black,
  fontSize: 13.0,
  decoration: TextDecoration.none,
);

Map<String, WidgetBuilder> routes = {
  PageRouteNames.login: (context) => LoginScreen(),
  PageRouteNames.home: (context) => const MyHomePage(),
};

class UserInfo {
  String id = '';
  String name = '';

  UserInfo({
    required this.id,
    required this.name,
  });

  bool get isEmpty => id.isEmpty;

  UserInfo.empty();
}

UserInfo currentUser = UserInfo.empty();
const String cacheUserIDKey = 'cache_user_id_key';
