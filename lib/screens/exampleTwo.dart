import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({Key? key}) : super(key: key);

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo> {
  List<PhotosModel> photoList = [];

  Future<List<PhotosModel>> getPhotoData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photos =
            PhotosModel(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photos);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Model Example"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<PhotosModel>>(
              future: getPhotoData(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index) {
                    if (snapshot.hasData) {
                      return ListTile(
                        leading: Image.network(
                          snapshot.data![index].url.toString(),
                          errorBuilder: (context, error, stackTrace) {
                            return Text("Image Error");
                          },
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text(snapshot.data![index].id.toString()),
                      );
                    } else {
                      return Text("Loading");
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class PhotosModel {
  String? title, url;
  int id;

  PhotosModel({required this.title, required this.url, required this.id});
}
