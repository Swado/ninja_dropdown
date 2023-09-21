import 'package:flutter/material.dart';
import 'package:ninja_dropdown/ninja_dropdown.dart';

class Example1 extends StatefulWidget {
  final String title;
  const Example1({super.key, required this.title});

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    List fruitList = [
      "Banana",
      "Apple",
      "kiwi",
      "Orange",
      "Grapes",
      "Custard apple"
    ];
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: NinjaDropdown(
              hintText: "hell0",
              itemList: fruitList,
              onTap: (int val) {},
              onOpenTrailingIcon: Icons.grade,
              onCloseTrailingIcon: Icons.cloud,
              // menuBorderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(50),
              //     bottomRight: Radius.circular(50)),
              // textBoxDecoration: const BoxDecoration(
              //     color: Colors.amber,
              //     gradient: RadialGradient(
              //         colors: [Colors.white, Colors.blue], radius: 5),
              //     shape: BoxShape.rectangle,
              //     borderRadius: BorderRadius.all(Radius.circular(10))),
              // menuColor: Colors.blue[100]!,
              // selectedItemColor: Colors.blue[300]!,
            ),
          ),
        ],
      ),
    );
  }
}
