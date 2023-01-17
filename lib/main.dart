import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_tutorial/model/postModel.dart';
import 'package:flutter_rest_api_tutorial/screens/exampleThree.dart';
import 'package:flutter_rest_api_tutorial/screens/exampleTwo.dart';
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
      home: ExampleThree(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<PostModel>> getData() async {
    // List<PostModel> postList = [];
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    List jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonResponse.map((job) => PostModel.fromJson(job)).toList();
    } else {
      return jsonResponse[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Api"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<PostModel>>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Title: ${snapshot.data![i].title}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snapshot.data![i].body.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("Loading");
                  }
                },
              ),
            )
          ],
        ));
  }
}
