import 'package:flutter/material.dart';
import 'package:breaking_bad_data/models/api_service.dart';

class CharScreenViewModel extends ChangeNotifier{
  doApiService(c,context)async {
    await ApiService().getApi(c,context);
    notifyListeners();
  }

  doLogout(BuildContext context)async{
    await ApiService().logout(context);
    notifyListeners();
  }

  String doGetInitialPermission(){
    //await ApiService().getInitialPermission();
    //print('in char view model${await ApiService().getInitialPermission()}');
    print('i am user type $userType');
    return userType;

  }

  // doGetInfo(){
  //   info;
  // }

  doIsError()async{
    await ApiService().isError;
    print('is Error value ${await ApiService().isError}');
    notifyListeners();
  }
}