import 'package:breaking_bad_data/views/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:breaking_bad_data/widgets/const_container.dart';
import 'package:breaking_bad_data/theme/constant_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

var countSearch;

Map _info={};
Map get info=>_info;
set info(Map inf){
  _info=inf;
}

var returnedWidget;
String userType='Admin';

class ApiService{
  bool isError=false;

  logout(BuildContext context)async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.setBool('status', true);
    await prefs.setString('type', 'Admin');
    info.clear();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
  }

  getInitialPermission()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    userType= prefs.getString('type')??'Admin';
  }

  getApi (var count,BuildContext context) async{
    var _request=http.Request('GET',Uri.parse('https://www.breakingbadapi.com/api/characters?limit=$count'));
    http.StreamedResponse _response=await _request.send();
    if(_response.statusCode ==200){
      await _response.stream.bytesToString().then((value) {
        var breakingData=json.decode(value);
        int l=breakingData.length;
        for(int i=0;i<l;i++){
          _info[i]=breakingData[i];
        }
        info=_info;
        countSearch=count;
        getInitialPermission();
      });
    }
    else{
      isError=true;
      //returnedWidget=ConstContainer(containerColor: ConstColor.errorColor, label: 'Please Check Your Internet Then Try again', textColor: ConstColor.whiteColor);
      print(_response.reasonPhrase);
    }

  }

}