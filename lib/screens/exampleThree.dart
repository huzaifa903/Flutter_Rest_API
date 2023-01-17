import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api_tutorial/model/userModel.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  // List<UserModel> userList = [];
  Future<List<UserModel>> getUserData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    List jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return jsonResponse.map((e) => UserModel.fromJson(e)).toList();
      // for (Map i in data) {
      //   userList.add(UserModel.fromJson(i));
      // }
      // return userList;
    } else {
      return jsonResponse[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex Json Example#03"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(snapshot.data![index].id.toString())
                              ReusableRow(
                                name: "ID:",
                                value: snapshot.data![index].id.toString(),
                              ),
                              ReusableRow(
                                name: "Name:",
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusableRow(
                                  name: "Address",
                                  value: snapshot.data![index].address!.street
                                      .toString()),
                              ReusableRow(
                                  name: "Lat",
                                  value: snapshot.data![index].address!.geo!.lat
                                      .toString())
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Text("Loading");
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String name, value;
  const ReusableRow({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(value),
      ],
    );
  }
}
