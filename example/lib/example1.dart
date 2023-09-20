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
      "Orangesddsfavvasdvsdvdsvadvasdva",
      "Grapes",
      "Custard apple"
    ];
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: NinjaDropdown(
                isArrowEnabled: true,
                menuBorderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(10)),
                spacing: 20,
                hintText: "hell0",
                itemList: fruitList,
                onTap: (int val) {},
                isTrailingIcon: true,
                onOpenTrailingIcon: Icons.grade,
                onCloseTrailingIcon: Icons.cloud,
                textBoxDecoration: const BoxDecoration(
                    color: Colors.amber,
                    gradient:
                        LinearGradient(colors: [Colors.amber, Colors.red]),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          DropdownMenu(
              label: const Text("help"),
              hintText: "hello",
              dropdownMenuEntries: fruitList
                  .map((e) => DropdownMenuEntry(value: e, label: e))
                  .toList())
        ],
      )),
    );
  }
}
