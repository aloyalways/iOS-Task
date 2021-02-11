import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:ios_task/screens/users_info.dart';

class UsersLists extends StatefulWidget{
  @override
  _UsersLists createState() => _UsersLists();
}

class _UsersLists extends State<UsersLists>{
  final String apiUrl = "http://aryu.co.in/tracking/viewreport";
  Future<List<dynamic>> fetchUsers() async{
    var result = await http.get(apiUrl);
    return json.decode(result.body)['success'];
  }

  String _name(dynamic user){
    return user['name'];
  }

  String _contact(dynamic user){
    return user['contact'];
  }

  String _descp(dynamic user){
    return user['description'];
  }

  String _address(dynamic user){
    return user['address'];
  }

  String _empcode(dynamic user){
    return user['empcode'];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Lists')
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fetchUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder:(context)=>UsersInfo(
                        name: _name(snapshot.data[index]),
                        contact: _contact(snapshot.data[index]),
                        desp: _descp(snapshot.data[index]),
                        address: _address(snapshot.data[index]),
                        empcode: _empcode(snapshot.data[index])
                      )),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(_name(snapshot.data[index])),
                      subtitle: Text("Click to know full detail!"),
                    )
                  ));
                }
              );
            } else{
              return Center(child: CircularProgressIndicator());
            }
          }
        )
      )
    );
  }
}