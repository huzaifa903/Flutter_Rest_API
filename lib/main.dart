import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_tutorial/model/userModel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List userData = [];
  Future getData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userData = data;
      return userData;
    } else {
      throw Exception("No data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Api"),
        ),
        body: FutureBuilder<dynamic>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Text("Loading");
            } else {
              return ListView.builder(
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  return Text(userData[index]);
                },
              );
            }
            return Text("data");
          },
        ));
  }
}
