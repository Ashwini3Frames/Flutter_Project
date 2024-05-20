import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_application/pages/add_screen.dart';
import 'package:my_application/pages/home_page.dart';
import 'package:my_application/pages/login_page.dart';
import 'package:my_application/pages/signup_page.dart';
import 'package:my_application/pages/splash_screen.dart';
import 'package:my_application/pages/update_screen.dart';
import 'package:my_application/pages/view_screen.dart';
import 'package:my_application/models/individual_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignUpPage(),
        ),
        GetPage(
          name: '/home',
          page: () {
           // final HomeController homeController = Get.put(HomeController());
            return HomeScreen();
          },
        ),
        GetPage(
          name: '/add',
          page: () => AddScreen(),
        ),
        GetPage(
          name: '/update',
          page: () {
            final Individual user = Get.arguments as Individual;
            return UpdateScreen(user: user);
          },
        ),
        GetPage(
          name: '/view',
          page: () {
            final Individual user = Get.arguments as Individual;
            return ViewScreen(user: user);
          },
        ),
      ],
    );
  }
}
