import 'package:breaking_bad_data/models/api_service.dart';
import 'package:breaking_bad_data/widgets/const_container.dart';
import 'package:breaking_bad_data/widgets/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:breaking_bad_data/view_model/char_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:breaking_bad_data/view_model/welcome_screen_view_model.dart';
import 'actor_screen.dart';

class CharScreen extends StatelessWidget with ChangeNotifier{
  TextEditingController controller=TextEditingController();
  var taped;
  int id=0;

  @override
  Widget build(BuildContext context) {
    //var infoMap=Provider.of<CharScreenViewModel>(context,listen:false).doGetInfo();

    return SafeArea(
      child: Consumer2<CharScreenViewModel,WelcomeScreenProvider>(
        builder: (context,charScreenViewModel,welcomeScreenProvider,child){
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
            drawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children:[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: LogoImage(),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout), title: const Text("log out"),
                      onTap: () {
                          Provider.of<CharScreenViewModel>(context,listen: false).doLogout(context);
                      },
                    ),
                  ]
              ),
            ),

            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: Container(
                width:double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: controller,
                    onChanged: (String? searchText){
                        taped=searchText;
                    },
                    decoration: InputDecoration(
                      prefixIcon: IconButton(icon: const Icon(Icons.search),color: Theme.of(context).accentColor,
                        onPressed: (){
                            print('pressed');
                            Provider.of<CharScreenViewModel>(context,listen: false).doApiService(taped, context);
                        },),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),color: Theme.of(context).accentColor,
                        onPressed: (){
                          controller.clear();
                            info.clear();
                            print(info);
                            taped='';
                        },
                      ),
                      hintText: 'Search ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),

            //body:infoMap.isNotEmpty?
            body: info.isNotEmpty?
            ListView.builder(
              shrinkWrap: true,
              //itemCount:infoMap.length,
              itemCount: info.length,
              itemBuilder: (BuildContext context,int index){
                return ListTile(
                  onTap: () {
                    //Map dataActor=infoMap[index];

                    Map dataActor=info[index];
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ActorScreen(
                        dataActor,
                        Provider.of<CharScreenViewModel>(context,listen: false).doGetInitialPermission()=='Admin'?Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //infoMap
                            ConstContainer(containerColor: Theme.of(context).scaffoldBackgroundColor, label: info[index]["name"], textColor: Theme.of(context).canvasColor),
                            const SizedBox(height: 10.0,),
                            //infoMap
                            ConstContainer(containerColor: Theme.of(context).accentColor, label: info[index]["nickname"], textColor: Theme.of(context).canvasColor),
                            const SizedBox(height: 10.0,),
                            //infoMap
                            ConstContainer(containerColor: Theme.of(context).scaffoldBackgroundColor, label: info[index]["portrayed"], textColor: Theme.of(context).canvasColor),
                          ],
                        ):
                          Provider.of<CharScreenViewModel>(context,listen: false).doGetInitialPermission()=='Family'?Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //infoMap
                            ConstContainer(containerColor: Theme.of(context).scaffoldBackgroundColor, label: info[index]["name"], textColor: Theme.of(context).canvasColor),
                          ],
                        ):
                            Provider.of<CharScreenViewModel>(context,listen: false).doGetInitialPermission()=='Customer'?Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                //infoMap
                                ConstContainer(containerColor: Theme.of(context).scaffoldBackgroundColor, label: info[index]["nickname"], textColor: Theme.of(context).canvasColor),
                              ],
                        ):
                              Text('Batoul'),
                    )));
                  },

                  leading: Container(
                    padding: const EdgeInsets.all(3.0),
                    height: 100.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    //child: Image.network(infoMap[index]["img"],fit: BoxFit.fill,),

                    child: Image.network(info[index]["img"],fit: BoxFit.fill,),
                  ),
                  //title: Text(infoMap[index]["name"]),

                  title: Text(info[index]["name"]),
                  trailing: const Icon(
                    Icons.arrow_forward,
                  ),
                );
              },
            ):
              Padding(padding: const EdgeInsets.all(10.0),child: ConstContainer(containerColor: Theme.of(context).accentColor, label: 'There is No Item To Show Please Enter number of characters again', textColor: Theme.of(context).canvasColor))
        );
        }
      )
    );
  }
}
