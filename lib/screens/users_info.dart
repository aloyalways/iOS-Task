import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class UsersInfo extends StatelessWidget{
  String name;
  String contact;
  String desp;
  String address;
  String empcode;

  UsersInfo({this.name, this.contact, this.desp, this.address, this.empcode});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(name)
        ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Text("Contact: " + "$contact"),
            Text("Description: " + "$desp"),
            Text("Address: " + "$address"),
            Text("EMPcode: " + "$empcode"),
          ]
        ),
      )    
    ); 
  }
}
