import 'package:flutter/material.dart';
import 'package:video_call_firebase1/homepage.dart';

class FirstHomePage extends StatefulWidget {
  const FirstHomePage({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<FirstHomePage> createState() => _FirstHomePageState();
}

class _FirstHomePageState extends State<FirstHomePage> {
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
            const Text("Enter your User ID"),
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
                      builder: (context) => MyHomePage(
                            navigatorKey: widget.navigatorKey,
                            user: userid.text.toString(),
                          )),
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
