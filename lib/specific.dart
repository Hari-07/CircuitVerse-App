import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';


class Attributes{
  String name;

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
  Project project;

  Data({
    this.project,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      project: Project.fromJson(json['data'])
    );
  }
}


Data dataFromJson (String str) {
  final  jsonData = json.decode(str);
  return Data.fromJson(jsonData);
}

//URL OF THE API

var id = '';

Future<Data> getData() async {
  final response = await http.get('$url/$id');
  return dataFromJson(response.body);
}

class SpecificProject extends StatefulWidget {
  @override
  _SpecificProjectState createState() => _SpecificProjectState();
}


//Load Flag
bool flag = false;

class _SpecificProjectState extends State<SpecificProject> {
  
	TextEditingController idval = TextEditingController();

  List<Widget> buildChildren() {
    var builder = [
      Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 200,
              child: TextField(
								controller: idval,
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
                onSubmitted: (String str) {
                  setState(() {
                    id = str;
                    flag = true;
                  });
                },
                decoration: InputDecoration(

                  labelText: 'Enter ID',
                ),
              ),
            ),
            MaterialButton(
              
              minWidth: 100,
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Load'),
              onPressed: () {
                setState(() {
									id = idval.text;
                  flag = true;
                });
              },
            ),
          ],
        ),
      ),
    ];

    if (flag) {
      builder.add(
        Container(
          height: 100,
					child:Row(
						children: <Widget>[
							Padding(
							  padding: EdgeInsets.all(30),
							  child: Result(),
							),
						],
					)
        )
      );
    }
    return builder;
  }

	

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Info'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: buildChildren(),
        ),
      )
    );
  }
}

class Result extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Data>(
    	future: getData(),
    	builder: (context, snapshot) {
    		if(snapshot.hasData)
    			return Text('${snapshot.data.project.attributes.name}',style: TextStyle(fontSize: 30),);
    		else
    			return Text('Not Found',style: TextStyle(fontSize: 30),);
    	}
    );
  }
}
