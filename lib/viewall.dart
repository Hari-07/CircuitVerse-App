import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';


class Attributes{
  final String name;

  Attributes({
    this.name,
  });

  factory Attributes.fromJson(Map<String, dynamic> json3) {
    return Attributes(
      name: json3['name']
    );
  }
}

class Project {
  String id;
  String type;
  Attributes attributes;

  Project({
    this.id,
    this.type,
    this.attributes,
  });

  factory Project.fromJson(Map<String, dynamic> json2) {
    return Project(
      id : json2['id'],
      type : json2['type'],
      attributes : Attributes.fromJson(json2['attributes'])
    );
  }
}

class Data {
  List<Project> projects;

  Data({
    this.projects,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var list  = json['data'] as List;
    print(list.runtimeType);
    List<Project> projectsList = list.map((i) => Project.fromJson(i)).toList();
    return Data(
      projects : projectsList,
    );
  }
}


Data dataFromJson (String str) {
  final  jsonData = json.decode(str);
  return Data.fromJson(jsonData);
}

Future<Data> getData() async {
  final response = await http.get('$url');
  return dataFromJson(response.body);
}


class AllProjects extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Info'),
      ),
      backgroundColor: Colors.white,
      body:FutureBuilder<Data>(
        future: getData(),
        builder: (context, snapshot) {
          
          if(snapshot.hasData)
            return ListView.builder(
              itemCount: snapshot.data.projects.length,
              itemBuilder: (context,index) {
                return ListTile(
                  title: Text('${snapshot.data.projects[index].attributes.name}',style: TextStyle(fontSize: 30),),
                );
              }
            );
          else
            return Text('NotFound');
        }
      )
    );
  }
}



