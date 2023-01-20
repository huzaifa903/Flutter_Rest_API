import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print("Image not found");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var imageLenght = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');

    var request = http.MultipartRequest("POST", uri);

    var multiPartFile = http.MultipartFile('image', stream, imageLenght);

    request.files.add(multiPartFile);

    var response = await request.send();

    print("Image upload");
    setState(() {
      showSpinner = false;
    });
    if (response.statusCode == 200) {
    } else {
      print("Failed to load data");
      showSpinner = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(title: const Text("Image Upload")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    child: image == null
                        ? const Center(
                            child: Text('Pick Image'),
                          )
                        : Center(
                            child: Image.file(
                              File(image!.path).absolute,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: const Text("Upload Image"))
              ],
            ),
          )),
    );
  }
}
