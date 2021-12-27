import 'package:breaking_bad_data/views/welcome_screen.dart';
import 'package:breaking_bad_data/widgets/const_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:breaking_bad_data/views/char_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? check;

class DatabaseHelper{
  static final DatabaseHelper _instance =DatabaseHelper.internal();
  factory DatabaseHelper()=> _instance;

  static Database? _database;

  final String tableUser='User';
  final String columnName='username';
  final String columnPermission='permission';
  final String columnPassword='password';

  Future<Database> get database async{
    if(_database !=null){
      return _database!;
    }
    _database=await _initDb();
    return _database!;
  }

  DatabaseHelper.internal();

  _initDb()async{
    final dpPath=await getApplicationDocumentsDirectory();
    final path=join(dpPath.path,"breaking_bad.db");
    return await openDatabase(path, version: 1,onCreate: _createDB);
  }
  _createDB(Database db,int version)async{
    await db.execute(''
      "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, permission TEXT, password TEXT)");
  }

   insertUser (User user)async{
    var dbClient=await database;
    int res=await dbClient.insert('User', user.toMap());
    return res;
   }

  getInitialPage(BuildContext context)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    check= prefs.getBool('status')??true;
    print(check);
    if(check==false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CharScreen()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> WelcomeScreen()));
    }
  }

  getUserInfo(User user,BuildContext context)async{
    final prefs=await SharedPreferences.getInstance();
    final db=await database;
    List<Map> maps=await db.query(tableUser,
      columns:  [columnName, columnPermission, columnPassword],
      where: '$columnName = ? and $columnPermission = ? and $columnPassword = ?',
      whereArgs: [user.username, user.permission, user.password]
    );
    if(maps.isNotEmpty){
        print('user exist ! ! !');
        await prefs.setBool('status', false);
        await prefs.setString('type', user.permission);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CharScreen()));
        print('false');
        return user;
  }
    else{
      print('User Is Not Exist');
      print('false');
      return null;
   }
  }

  Future<dynamic> getUsers()async{
    final db=await _instance.database;
    var res=await db.query("user");
    List<User>? list=res.isNotEmpty ? res.map((e) => User.fromMap(e)).toList(): null;
    return list;
  }

}
