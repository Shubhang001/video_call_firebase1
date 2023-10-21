import 'package:flutter/material.dart';
import 'package:video_call_firebase1/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var userid1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 300,
          ),
          const Text("Enter User ID"),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 40,
            width: 300,
            child: TextField(
              controller: userid1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
            child: Container(
              height: 30,
              width: 100,
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: const Center(
                  child: Text(
                "Join",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ]),
      ),
    );
  }
}
