import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  void login(String email, password) async {
    try {
      final response =
          await http.post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Account Created Successfully");
        print(data);
        // return data;
      } else {
        print("Failed to Login");
      }
    } catch (e) {
      throw Exception("Failed to laod data $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Now"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(height: 40),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        login(_emailController.text.toString(),
                            _passController.text.toString());
                      },
                      child: const Text("Login")))
            ],
          ),
        ),
      ),
    );
  }
}
