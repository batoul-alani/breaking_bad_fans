import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback continueCallBack;

  // ignore: use_key_in_widget_constructors
  BlurryDialog(this.title,this.content,this.continueCallBack);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(filter: ImageFilter.blur(sigmaX: 6,sigmaY: 6),
    child: AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        IconButton(onPressed: (){
          continueCallBack();
        }, icon: Icon(Icons.close)),
      ],
    ),);
  }
}
