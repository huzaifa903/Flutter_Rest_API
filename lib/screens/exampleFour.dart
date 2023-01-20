import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FourthExampleWIthputModel extends StatefulWidget {
  const FourthExampleWIthputModel({Key? key}) : super(key: key);

  @override
  State<FourthExampleWIthputModel> createState() =>
      _FourthExampleWIthputModelState();
}

class _FourthExampleWIthputModelState extends State<FourthExampleWIthputModel> {
  var data;

  Future getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Without Model Example#04"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getData(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Text(data[index]['name']);
                      },
                    );
                    // for (int i = 0; i < data.length; i++) {
                    //   return Text(data[i]['name'].toString());
                    // }
                  }
                  return Text("loading");
                })),
          )
        ],
      ),
    );
  }
}
