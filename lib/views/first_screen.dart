import 'dart:async';
import 'package:breaking_bad_data/view_model/welcome_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:breaking_bad_data/widgets/logo_image.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
      builder: (context,welcomeScreenProvider,child) {
        Timer(const Duration(seconds: 2),()async{
          await Provider.of<WelcomeScreenProvider>(context,listen: false).doInitial(context);
        });
        return Center(
            child: LogoImage(),
        );
      }
      ),
    );
  }
}
