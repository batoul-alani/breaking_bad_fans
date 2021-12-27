import 'dart:io';
import 'package:breaking_bad_data/view_model/welcome_screen_view_model.dart';
import 'package:breaking_bad_data/views/first_screen.dart';
import 'view_model/char_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global=MyHttpOverrides();
  runApp(BasicScreen());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
        ..badCertificateCallback=(X509Certificate cert,String host,int port)=> true;
  }
}

// ignore: use_key_in_widget_constructors
class BasicScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider<WelcomeScreenProvider>(create: (context)=>WelcomeScreenProvider()),
        ChangeNotifierProvider<CharScreenViewModel>(create: (context)=>CharScreenViewModel()),
      ],
      child: MaterialApp(
        theme:ThemeData(
          scaffoldBackgroundColor: Colors.black,
          errorColor: Colors.red,
          accentColor: const Color(0xFF05CE91),
          canvasColor: Colors.white,
          primaryColor: Colors.white,
          indicatorColor: const Color(0xFF05CE91).withOpacity(0.3),
          backgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        home: FirstScreen(),
    ),
    );
    }
  }

