import 'package:flutter/material.dart';
import 'package:breaking_bad_data/data/user.dart';
import 'package:breaking_bad_data/models/database_helper.dart';

class WelcomeScreenProvider extends ChangeNotifier{

  WelcomeScreenProvider();
  DatabaseHelper databaseHelper=DatabaseHelper();

  String _type='';
  String get type=>_type;
  set type(String t){
    _type=t;
    notifyListeners();
  }


  buildData(){
    User user1=User('admin','Admin','123456');
    User user2=User('skylar','Family','12345');
    User user3=User('bones','Customer','12346');
    databaseHelper.insertUser(user1);
    databaseHelper.insertUser(user2);
    databaseHelper.insertUser(user3);
  }

  doLogin(String username1, String permission1, String password1,BuildContext context) async{
    User signInUser=User(username1,permission1,password1);
    _type=permission1;
    print(_type);
    await databaseHelper.getUserInfo(signInUser,context);
    return Future.value(signInUser);
  }

  doInitial(BuildContext context)async{
    await DatabaseHelper().getInitialPage(context);
    notifyListeners();
  }
}

