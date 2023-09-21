import 'package:flutter/material.dart';

/// Customisable dropdown allowing developers with more
/// flexibilty while configuring dropdown.
class NinjaDropdown extends StatefulWidget {
  ///Creates configuration for NinjaDropdown.
  const NinjaDropdown({
    required this.hintText,
    required this.itemList,
    required this.onTap,
    super.key,
    this.textBoxDecoration,
    this.isTrailingIcon = true,
    this.onCloseTrailingIcon = Icons.arrow_drop_down,
    this.onOpenTrailingIcon = Icons.arrow_drop_up,
    this.spacing = 10,
    this.isArrowEnabled = true,
    this.menuTextpadding = const EdgeInsets.all(8),
    this.menuColor = Colors.white,
    this.selectedItemColor = Colors.black12,
    this.menuBorderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  /// Hinttext for dropdown.
  final String hintText;

  /// ItemList for populating dropdown.
  final List<dynamic> itemList;

  /// onTap Function returns index of selected/tapped item.
  final void Function(int index) onTap;

  /// textBoxDecoration Property enables customisation of TextBox.
  /// Supported properties are color,border,shape,borderRadius,gradient.
  final BoxDecoration? textBoxDecoration;

  /// Boolean to enable trailing icon. Default [bool true].
  final bool isTrailingIcon;

  /// Set custom trailing icon on close. Default [Icons.arrow_drop_down].
  final IconData onCloseTrailingIcon;

  /// Set custom trailing icon on open. Default [Icons.arrow_drop_up].
  final IconData onOpenTrailingIcon;

  /// Spacing between Textbox and Menu. Default [10].
  final int spacing;

  /// Boolean to set design element arrow on menu card. Default [bool true].
  final bool isArrowEnabled;

  /// menuTextPadding enables padding for menu card items.
  final EdgeInsetsGeometry menuTextpadding;

  /// menuColor enables background color for menu card. Default [Colors.white].
  final Color menuColor;

  /// selectedItemColor enables background color for menu card selected item.
  /// Default [Colors.black12].
  final Color selectedItemColor;

  /// menuBorderRadius enables border radius for menu.
  /// Default [Radius.circular(10)].
  final BorderRadius menuBorderRadius;

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
    final renderBox =
        actionKey!.currentContext!.findRenderObject()! as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    final offset = renderBox.localToGlobal(Offset.zero);
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
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Material(
                      elevation: 4,
                      color: Colors.black,
                      child: Container(
                        key: const Key('arrowContainerKey'),
                        height: 10,
                        width: 20,
                        color: widget.menuColor,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Material(
                  key: const Key('menuCardKey'),
                  color: widget.menuColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: widget.menuBorderRadius,
                  ),
                  clipBehavior: Clip.hardEdge,
                  elevation: 30,
                  child: ListView.builder(
                    physics: const ScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: widget.itemList.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          floatingOverlayMenu?.remove();
                          floatingOverlayMenu = null;
                          widget.onTap(index);
                          isDropdownOpen = !isDropdownOpen;
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
                              color: Color.fromARGB(
                                255,
                                237,
                                236,
                                236,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          widget.itemList[index].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        border: Border.all(),
      ).copyWith(
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
                  ? widget.itemList[selectedIndex!].toString()
                  : widget.hintText,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.isTrailingIcon && isDropdownOpen)
            Icon(
              key: const Key('onOpenTrailingIcon'),
              widget.onOpenTrailingIcon,
            )
          else if (widget.isTrailingIcon && !isDropdownOpen)
            Icon(
              key: const Key('onCloseTrailingIcon'),
              widget.onCloseTrailingIcon,
            )
        ],
      ),
    );
  }
}

/// ArrowClipper class for creating custom clippath.
class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
