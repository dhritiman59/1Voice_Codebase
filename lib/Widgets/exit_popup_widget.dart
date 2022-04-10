import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowPopUpWidget  {
  void showPopUp(BuildContext context){
     showDialog(context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Confirm'),
              content: Text('Do you want to exit?'),
              actions: <Widget>[
                RaisedButton(
                  child: Text('No'),
                  color: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },),
                RaisedButton(
                    child: Text("Yes"),
                    color: Colors.white,
                    onPressed: (){
                      SystemNavigator.pop();
                    }
                )
              ],
            );
          }
      );
  }

}