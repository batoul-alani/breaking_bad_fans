class User{
   String _username='';
   String _permission='';
   String _password='';

  User( this._username, this._permission, this._password, );

  User.fromMap(dynamic obj){
    _username=obj['username'];
    _permission=obj['permission'];
    _password=obj['password'];
  }

  String get username=> _username;
  String get password=> _password;
  String get permission=> _permission;

  Map<String, Object?> toMap() {
    var map=<String, dynamic>{};
    map['username']=_username;
    map['permission']=_permission;
    map['password']=_password;
    return map;
  }
}
