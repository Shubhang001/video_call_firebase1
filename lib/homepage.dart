import 'package:flutter/material.dart';
import 'package:video_call_firebase1/videocall.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
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
                controller: userid,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => VideoCall(
                          localUsername: userid.text.toString(),
                          localUserId: userid.text.toString(),
                          roomId: "12345")),
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
          ],
        ),
      ),
    );
  }
}
