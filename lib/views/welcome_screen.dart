
import 'package:breaking_bad_data/widgets/logo_image.dart';
import 'package:provider/provider.dart';
import 'package:breaking_bad_data/view_model/welcome_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:breaking_bad_data/widgets/text_form.dart';

class WelcomeScreen extends StatelessWidget with ChangeNotifier{
  @override
  Widget build(BuildContext context) {

    final _formKey=GlobalKey<FormState>();
    String username='';
    String password='';
    String permission='- Select User Type -';

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Consumer<WelcomeScreenProvider>(
              builder: (context,welcomeScreenProvider,child){
                Provider.of<WelcomeScreenProvider>(context,listen:false).buildData();
               return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        LogoImage(),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          TextForm(TextInputType.name, 'Name', username,false,
                                (value){
                                  username=value;
                          },
                          ),
                          const SizedBox(height: 10.0,),
                          TextForm(TextInputType.visiblePassword, 'Password', password,true,
                                (value){
                              password=value;
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              style: TextStyle(color:Theme.of(context).accentColor,fontSize: 16.0),
                              decoration: InputDecoration(
                                 errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Theme.of(context).errorColor)),
                                 enabledBorder:  OutlineInputBorder(borderSide:BorderSide(color: Theme.of(context).primaryColor)),
                                 focusedBorder:  OutlineInputBorder(borderSide:BorderSide(color:Theme.of(context).accentColor)),),
                                value:permission,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                validator: (value){
                                  return(value=='- Select User Type -'? 'Please enter your user type':null);
                                },
                                onChanged: (String? newValue){
                                  permission=newValue!;
                                },
                                items: <String>['- Select User Type -','Admin','Family','Customer']
                                    .map<DropdownMenuItem<String>>((String e) {
                                  return DropdownMenuItem(child: Text(e), value: e,);
                                }).toList()),
                          ),
                        ],),

                        Container(
                            padding:  const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context).accentColor,
                            ),
                            child: TextButton(
                              child:  Text('Sign in ',style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                              ),),
                              onPressed: (){
                                  if (_formKey.currentState!.validate()) {
                                    Provider.of<WelcomeScreenProvider>(context,listen:false).doLogin(username, permission, password, context);
                                  }
                                },
                            ),
                          ),
                      ],
                    ),
                  ),
              );
               },
          ),
        ),
      ),
    );
  }
}
