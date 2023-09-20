// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninja_dropdown/widget/ninja_dropdown_widget.dart';

void main() {
  List fruitList = [
    "Banana",
    "Apple",
    "kiwi",
    "Orange",
    "Grapes",
    "Custard apple"
  ];
  group("NinjaDropdown tests for text box", () {
    BoxDecoration textboxDecoration = const BoxDecoration(
        color: Colors.amber,
        gradient: LinearGradient(colors: [Colors.amber, Colors.red]),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10)));
    var ninjaPage = MaterialApp(
      home: NinjaDropdown(
        hintText: "hintText",
        itemList: fruitList,
        onTap: (val) {},
        textBoxDecoration: textboxDecoration,
      ),
    );
    testWidgets('Hint text assigned correctly', (WidgetTester tester) async {
      await tester.pumpWidget(ninjaPage);

      final hintText = find.text("hintText");
      expect(hintText, findsOneWidget);
    });

    testWidgets('textBoxDecoration property check for box radius set correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(ninjaPage);

      // Check for correct box radius.
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));
      var ctnr = tester.widget<Container>(textBoxCtrl);
      final decoration = ctnr.decoration as BoxDecoration;
      final borderRadius = decoration.borderRadius as BorderRadius;

      expect(borderRadius.topLeft, const Radius.circular(10));
    });

    testWidgets("textBoxDecoration property Color and gradient set correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(ninjaPage);

      // Check for Gradient and color
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));
      var ctnr = tester.widget<Container>(textBoxCtrl);
      final decoration = ctnr.decoration as BoxDecoration;
      final gradient = decoration.gradient as Gradient;
      final color = decoration.color as Color;

      expect(
          gradient, const LinearGradient(colors: [Colors.amber, Colors.red]));
      expect(color, Colors.amber);
    });
  });

  group('Trailing icon tests', () {
    testWidgets("Default trailing icon", (WidgetTester tester) async {
      final ninjaPage = MaterialApp(
        home: NinjaDropdown(
          hintText: "hintText",
          itemList: fruitList,
          onTap: (val) {},
        ),
      );
      await tester.pumpWidget(ninjaPage);

      final iconCtrl = find.byKey(const Key("onCloseTrailingIcon"));
      final iconCtrl2 = find.byKey(const Key("onOpenTrailingIcon"));

      // Inital closed dropdown state
      expect(iconCtrl, findsOneWidget);
      expect(iconCtrl2, findsNothing);
      await tester.tap(iconCtrl);
      await tester.pump(const Duration(microseconds: 10));

      // Open dropdown state
      expect(iconCtrl, findsNothing);
      expect(iconCtrl2, findsOneWidget);
    });
    testWidgets("isTrailingIcon set to false", (WidgetTester tester) async {
      final ninjaPage = MaterialApp(
        home: NinjaDropdown(
          hintText: "hintText",
          itemList: fruitList,
          onTap: (val) {},
          isTrailingIcon: false,
        ),
      );
      await tester.pumpWidget(ninjaPage);

      final iconCtrl = find.byKey(const Key("onCloseTrailingIcon"));
      final iconCtrl2 = find.byKey(const Key("onOpenTrailingIcon"));
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));

      // Inital closed dropdown state
      expect(iconCtrl, findsNothing);
      expect(iconCtrl2, findsNothing);

      await tester.tap(textBoxCtrl);
      await tester.pump(const Duration(microseconds: 10));

      // Open dropdown state
      expect(iconCtrl, findsNothing);
      expect(iconCtrl2, findsNothing);
    });
    testWidgets("isTrailingIcon set to true and custom icons passed",
        (WidgetTester tester) async {
      final ninjaPage = MaterialApp(
        home: NinjaDropdown(
          hintText: "hintText",
          itemList: fruitList,
          onTap: (val) {},
          isTrailingIcon: true,
          onCloseTrailingIcon: Icons.cloud,
          onOpenTrailingIcon: Icons.star,
        ),
      );
      await tester.pumpWidget(ninjaPage);

      final iconCtrl = find.byKey(const Key("onCloseTrailingIcon"));
      final iconCtrl2 = find.byKey(const Key("onOpenTrailingIcon"));

      // Trailing Icon for onClose
      final ctrl = tester.widget<Icon>(iconCtrl);
      expect(ctrl.icon, Icons.cloud);
      expect(find.byIcon(Icons.cloud), findsOneWidget);

      await tester.tap(iconCtrl);
      await tester.pump(const Duration(microseconds: 10));

      // Open dropdown state
      final ctrl2 = tester.widget<Icon>(iconCtrl2);
      expect(ctrl2.icon, Icons.star);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group("Menu properties", () {
    final ninjaPage = MaterialApp(
      home: NinjaDropdown(
        hintText: "hintText",
        itemList: fruitList,
        onTap: (val) {},
        spacing: 30,
        menuColor: Colors.yellow,
        selectedItemColor: Colors.black12,
        menuBorderRadius:
            const BorderRadius.horizontal(left: Radius.circular(10)),
      ),
    );
    testWidgets("Arrow enabled for menu card", (WidgetTester tester) async {
      await tester.pumpWidget(ninjaPage);
      final arrowKey = find.byKey(const Key("arrowContainerKey"));
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));

      // Open menu card.
      await tester.tap(textBoxCtrl);
      await tester.pump(const Duration(microseconds: 10));

      // Check if arrow present.
      expect(arrowKey, findsOneWidget);
    });
    testWidgets("Arrow disabled for menu card", (WidgetTester tester) async {
      final ninjaPage = MaterialApp(
        home: NinjaDropdown(
          hintText: "hintText",
          itemList: fruitList,
          onTap: (val) {},
          isArrowEnabled: false,
        ),
      );
      await tester.pumpWidget(ninjaPage);
      final arrowKey = find.byKey(const Key("arrowContainerKey"));
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));

      // Open menu card.
      await tester.tap(textBoxCtrl);
      await tester.pump(const Duration(microseconds: 10));

      // Check if arrow absent.
      expect(arrowKey, findsNothing);
    });
    testWidgets("Menu card and Arrow color", (WidgetTester tester) async {
      await tester.pumpWidget(ninjaPage);
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));

      // Open menu card.
      await tester.tap(textBoxCtrl);
      await tester.pump(const Duration(microseconds: 10));

      final arrowKey = find.byKey(const Key("arrowContainerKey"));
      final arrowWidget = tester.widget<Container>(arrowKey);
      final menuCardKey = find.byKey(const Key("menuCardKey"));
      final menuCardWidget = tester.widget<Material>(menuCardKey);
      // Check for menu card and arrow color.
      expect(menuCardWidget.color, Colors.yellow);
      expect(arrowWidget.color, Colors.yellow);
    });
    testWidgets("Menu card border radius", (WidgetTester tester) async {
      await tester.pumpWidget(ninjaPage);
      final textBoxCtrl = find.byKey(const Key("textBoxKey"));

      // Open menu card.
      await tester.tap(textBoxCtrl);
      await tester.pump(const Duration(microseconds: 10));

      final menuCardKey = find.byKey(const Key("menuCardKey"));
      final menuCardWidget = tester.widget<Material>(menuCardKey);
      // Check for menu card color.
      expect(
          menuCardWidget.shape,
          const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(10))));
    });
  });
}
