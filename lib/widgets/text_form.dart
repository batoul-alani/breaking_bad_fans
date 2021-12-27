import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextInputType type;
  final String label;
  final dynamic changedValue;
  final bool isPassword;
  final void Function(String)? onChanged;

  // ignore: use_key_in_widget_constructors
  TextForm(this.type,this.label,this.changedValue,this.isPassword,this.onChanged);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).accentColor,
      style: TextStyle(
        color: Theme.of(context).backgroundColor,
      ),
      obscureText: isPassword,
      keyboardType: type,
      validator:
          (value){
        return(value==''? 'Please enter your $label':null);
      },

      decoration: InputDecoration(
        errorBorder:  OutlineInputBorder(borderSide:BorderSide(color: Theme.of(context).errorColor)),
        enabledBorder:  OutlineInputBorder(borderSide:BorderSide(color: Theme.of(context).canvasColor)),
        focusedBorder:  OutlineInputBorder(borderSide:BorderSide(color: Theme.of(context).accentColor)),
        labelText: label,
        labelStyle:  TextStyle(
            color: Theme.of(context).accentColor,
          ),
      ),
      onChanged: onChanged,
    );
  }
}
