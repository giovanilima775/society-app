import 'package:flutter/material.dart';
import 'package:society_app/login_page.dart';

import  'app_controller.dart';
import  'home_page.dart';
import  'register_page.dart';
import  'edit_sports_court_page.dart';
import  'register_sports_court_page.dart';

class AppWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
      return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {   
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: AppController.instance.isDartTheme ? Brightness.dark : Brightness.light,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage('', '', 0),
            '/register': (context) => RegisterPage(),
            '/register_sports_court_page': (context) => RegisterSportsCourtPage('', '', 0),
            '/edit_sports_court_page': (context) => EditSportsCourtPage('', '', null, null),
          },
        );
      },
    );
  }
}
