import 'package:flutter/material.dart';

class NinjaDropdown extends StatefulWidget {
  final String hintText;
  final List itemList;
  final Function(int val) onTap;
  final BoxDecoration? textBoxDecoration;
  final bool isTrailingIcon;
  final IconData onCloseTrailingIcon;
  final IconData onOpenTrailingIcon;
  final int spacing;
  final bool isArrowEnabled;
  final EdgeInsetsGeometry menuTextpadding;
  final Color menuColor;
  final Color selectedItemColor;
  final BorderRadius menuBorderRadius;
  const NinjaDropdown(
      {super.key,
      required this.hintText,
      required this.itemList,
      required this.onTap,
      this.textBoxDecoration,
      this.isTrailingIcon = true,
      this.onCloseTrailingIcon = Icons.arrow_drop_down,
      this.onOpenTrailingIcon = Icons.arrow_drop_up,
      this.spacing = 10,
      this.isArrowEnabled = true,
      this.menuTextpadding = const EdgeInsets.all(8),
      this.menuColor = Colors.white,
      this.selectedItemColor = Colors.black12,
      this.menuBorderRadius = const BorderRadius.all(Radius.circular(10))});

  @override
  State<NinjaDropdown> createState() => _NinjaDropdownState();
}

class _NinjaDropdownState extends State<NinjaDropdown> {
  GlobalKey? actionKey;
  bool isDropdownOpen = false;
  double height = 0;
  double width = 0;
  double xPosition = 0;
  double yPosition = 0;
  OverlayEntry? floatingOverlayMenu;
  int? selectedIndex;
  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.hintText);
    super.initState();
  }

  void dropdownData() {
    RenderBox renderBox =
        actionKey!.currentContext?.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
            left: xPosition,
            width: width,
            top: yPosition + height + widget.spacing,
            child: SizedBox(
                height: height * 5,
                child: Column(
                  children: [
                    if (widget.isArrowEnabled)
                      Align(
                        alignment: const Alignment(0, 0),
                        child: ClipPath(
                            clipper: ArrowClipper(),
                            child: Material(
                              elevation: 4,
                              color: Colors.black,
                              child: Container(
                                  key: const Key("arrowContainerKey"),
                                  height: 10,
                                  width: 20,
                                  color: widget.menuColor),
                            )),
                      ),
                    Expanded(
                      child: Material(
                        key: const Key("menuCardKey"),
                        color: widget.menuColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: widget.menuBorderRadius),
                        elevation: 30,
                        child: ListView.builder(
                            physics: const ScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: widget.itemList.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      floatingOverlayMenu?.remove();
                                      floatingOverlayMenu = null;
                                    });
                                  },
                                  child: Container(
                                    padding: widget.menuTextpadding,
                                    decoration: BoxDecoration(
                                        color: index == selectedIndex
                                            ? widget.selectedItemColor
                                            : null,
                                        border: const Border(
                                            bottom: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 237, 236, 236)))),
                                    child: Text(
                                      widget.itemList[index],
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpen) {
            floatingOverlayMenu?.remove();
            floatingOverlayMenu = null;
          } else {
            dropdownData();
            floatingOverlayMenu = _createOverlayEntry();
            Overlay.of(context).insert(floatingOverlayMenu!);
          }
          isDropdownOpen = !isDropdownOpen;
        });
      },
      child: textBox(),
    );
  }

  Container textBox() {
    return Container(
      key: const Key('textBoxKey'),
      width: 200,
      decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(style: BorderStyle.solid))
          .copyWith(
        color: widget.textBoxDecoration?.color,
        border: widget.textBoxDecoration?.border,
        shape: widget.textBoxDecoration?.shape,
        borderRadius: widget.textBoxDecoration?.borderRadius,
        gradient: widget.textBoxDecoration?.gradient,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
                selectedIndex != null
                    ? widget.itemList[selectedIndex!]
                    : widget.hintText,
                overflow: TextOverflow.ellipsis),
          ),
          if (widget.isTrailingIcon && isDropdownOpen)
            Icon(
                key: const Key("onOpenTrailingIcon"),
                (widget.onOpenTrailingIcon))
          else if (widget.isTrailingIcon && !isDropdownOpen)
            Icon(
                key: const Key("onCloseTrailingIcon"),
                (widget.onCloseTrailingIcon))
        ],
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
