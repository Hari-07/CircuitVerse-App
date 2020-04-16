import 'package:flutter/material.dart';
import 'viewall.dart';
import 'specific.dart';

//API Endpoint URL
String url = 'http://10.0.2.2:8080/api/v0/projects';
var id;

void main() {
	runApp(
		MaterialApp(
			title: 'Projects Info',
			home: HomePage(),
			debugShowCheckedModeBanner: false,
		)
	);
}

class HomePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				title: Text('CircuitVerse Projects'),
			),
			body: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Padding(
							  padding: const EdgeInsets.all(60),
							  child: MaterialButton(
							  	height: 80,
							  	minWidth: 200,
                  color: Colors.blue,
							  	textColor: Colors.white,
							  	child: Text('View All', style: TextStyle(fontSize: 25),),
							  	onPressed: () {
							  		Navigator.push(context,MaterialPageRoute(builder: (context) => AllProjects()),);
							  	},
							  ),
							),
							Padding(
							  padding: const EdgeInsets.all(60),
							  child: MaterialButton(
							  	height: 80,
							  	minWidth: 200,
							  	color: Colors.blue,
							  	textColor: Colors.white,
							  	child: Text('View by ID', style: TextStyle(fontSize: 25),),
							  	onPressed: () {
							  		Navigator.push(context,MaterialPageRoute(builder: (context) => SpecificProject()),);
							  	},
							  ),
							)
						],
					),
				],
			),
		);
	}
}
