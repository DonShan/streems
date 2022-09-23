import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController _controller = StreamController();

//Add Data by using sink
  addStreamData() async {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 2));
      _controller.sink.add(i);
    }
  }

// To run streem call inside the initState
  @override
  void initState() {
    super.initState();
    addStreamData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: const Text("App bar"),
      ),

      //Columan wrape with stream builder
      body: Center(
        child: StreamBuilder(
            stream: _controller.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("This is an error");
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              //Passing Stream data into text
              return Column(
                children: [
                  Text(
                    "${snapshot.data}",
                  ),
                ],
              );
            }),
      ),
    );
  }
}
