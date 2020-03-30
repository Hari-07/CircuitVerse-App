import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';

//Initiialisations
List<Project> P = [];
int page = 1;
bool full = false;

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
  
    List<Project> projectsList = list.map((i) => Project.fromJson(i)).toList();
    print(projectsList);
    if(projectsList.isEmpty)
      full = true;
    P.addAll(projectsList);
    return Data(
      projects : P,
    );
  }
}


Data dataFromJson (String str) {
  final  jsonData = json.decode(str);
  return Data.fromJson(jsonData);
}

Future<Data> getData() async {
  final response = await http.get('$url?page=$page');
  return dataFromJson(response.body);
}



class AllProjects extends StatefulWidget {  

  @override
  _AllProjectsState createState() {
    page = 1;
    return _AllProjectsState();
  }
}

class _AllProjectsState extends State<AllProjects> {
  
  ScrollController sc;
  
  void initstate() {
    sc = ScrollController();
    sc.addListener(scListener);
  }

  scListener() {
    print("Changed");
    if( sc.offset >= sc.position.maxScrollExtent && !sc.position.outOfRange) {
      setState(() {
        print("Reached Bottom");
      });
    }
  }

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
              controller: sc,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(!full) {
            setState(() {
              page+=1;
            }); 
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



