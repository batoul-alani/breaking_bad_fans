import 'package:flutter/material.dart';

class ActorScreen extends StatelessWidget with ChangeNotifier{
  final Map actorInformation;
  final Widget actorWidget;

  // ignore: use_key_in_widget_constructors
  ActorScreen(this.actorInformation,this.actorWidget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children:[
        Image.network(actorInformation["img"],fit: BoxFit.cover,),

        Container(
          padding: const EdgeInsets.all(25.0),
          child: actorWidget,
        ),
      ]),
    );
  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
//
// ],
// ),