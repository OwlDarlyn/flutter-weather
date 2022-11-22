import 'package:flutter/material.dart';
import 'widgets/search_city_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      const SearchCityWidget(), //footer
      Container(
          margin: const EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: Colors.grey),
          height: 70,
          child: Text("Daryna Parena - ${DateTime.now().year}")),
    ]))));
  }
}
