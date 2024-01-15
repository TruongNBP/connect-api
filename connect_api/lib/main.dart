import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AddUserScreen(),
    );
  }
}

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();

  Future<void> addUser() async {
    if (name.text.isNotEmpty || age.text.isNotEmpty || email.text.isNotEmpty) {
      try {
        const uri =
            "https://demophp9704.000webhostapp.com/Mob403_TruongNBP_API/api_add.php";
        final res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "age": age.text,
          "email": email.text,
        });

        final response = jsonDecode(res.body);
        if (response["success"] == true) {
          print("Add user success");
        } else {
          print("Add user failed");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please enter all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 50),
            TextFormField(
              controller: age,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your age',
              ),
            ),
            const SizedBox(height: 50),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email address',
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: addUser,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size.fromWidth(500),
                ),
              ),
              child: const Text('Add user'),
            ),
          ],
        ),
      ),
    );
  }
}
