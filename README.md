
# NinjaDropdown 🐱‍👤

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

NinjaDropdown is a highly customisable dropdown intended for flexibilty while implementing dropdowns.
It enables you to set custom shapes and properties to various dropdown components. Thus enancing look
and feel of complete app.


## Demo 😁

Following are examples of how Ninja Dropdown can be used.
<img src="screenshots\NinjaDropdown.png" alt="drawing"/>


## Code Snippets 🐱‍💻
* Default

```javascript
NinjaDropdown(
              hintText: "hell0",
              itemList: fruitList,
              onTap: (int val) {},
            ),
```
* Custom trailing icons

```javascript
NinjaDropdown(
              hintText: "hell0",
              itemList: fruitList,
              onTap: (int val) {},
              onOpenTrailingIcon: Icons.grade,
              onCloseTrailingIcon: Icons.cloud,
            ),
```
* Custom Fun

```javascript
NinjaDropdown(
              hintText: "hell0",
              itemList: fruitList,
              onTap: (int val) {},
              onOpenTrailingIcon: Icons.grade,
              onCloseTrailingIcon: Icons.cloud,
              menuBorderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              textBoxDecoration: const BoxDecoration(
                  color: Colors.amber,
                  gradient: RadialGradient(
                      colors: [Colors.white, Colors.blue], radius: 5),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              menuColor: Colors.blue[100]!,
              selectedItemColor: Colors.blue[300]!,
            ),
```


## Features ✨

- Customisable textbox
- Customisable Menu card
- Add custom trailing icons
- Custom color properties for elements
- Spacing between Menu card and Textbox.
- Selected item color can be modified.
- Arrow design card can be enabled/disabled.

## Properties 💖

| Property             | Type |Description|                                                               
| ----------------- | ----- | ------------------------------------------------------------------ |
| hintText | String | Hinttext for dropdown. |
| itemList | List<dynamic> | ItemList for populating dropdown. |
| onTap | void Function | Function returns index of selected/tapped item. |
| textBoxDecoration | BoxDecoration? | Property enables customisation of TextBox. |
| isTrailingIcon | bool | Boolean to enable trailing icon. |
| onCloseTrailingIcon | IconData |Set custom trailing icon on close. |
| onOpenTrailingIcon | IconData | Set custom trailing icon on open. |
| spacing | int | Spacing between Textbox and Menu. |
| isArrowEnabled | bool | Boolean to set design element arrow on menu card. |
| menuTextpadding | EdgeInsetsGeometry | Enables padding for menu card items. |
| menuColor | Color | Enables background color for menu card. |
| selectedItemColor | Color | Enables background color for menu card selected item. |
| menuBorderRadius | BorderRadius | Enables border radius for menu. |


## Authors 🙌

- [@Swado](https://github.com/Swado)

