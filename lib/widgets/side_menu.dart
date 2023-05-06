import 'package:flutter/material.dart';
import 'package:studio/widgets/menu_item_list.dart';

enum SideMenuPosition {
  top,
  left,
  right,
}

class SideMenu extends StatefulWidget {
  const SideMenu({
    required this.parentContext,
    this.position = SideMenuPosition.left,
    super.key,
  });
  final SideMenuPosition position;
  final BuildContext parentContext;
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late final Offset menuOffset;
  late bool isOpen;
  static const _menuCorcnerRadius = 20.0;
  static const _menuSize = 70.0;
  late Matrix4 transform;

  @override
  void initState() {
    super.initState();
    menuOffset = const Offset(150, 0);
    isOpen = false;
    transform = getCloseTransform();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInCubic,
      transform: transform,
      child: Align(
        alignment: widget.position == SideMenuPosition.right
            ? Alignment.centerRight
            : widget.position == SideMenuPosition.left
                ? Alignment.centerLeft
                : Alignment.topCenter,
        child: SizedBox(
          height: widget.position == SideMenuPosition.top
              ? _menuSize
              : MediaQuery.of(context).size.height / 3,
          width: widget.position == SideMenuPosition.top
              ? MediaQuery.of(context).size.width / 1.5
              : _menuSize,
          child: Stack(
            children: [
              Align(
                alignment: widget.position == SideMenuPosition.right
                    ? Alignment.centerRight
                    : widget.position == SideMenuPosition.left
                        ? Alignment.centerLeft
                        : Alignment.topCenter,
                child: Container(
                  padding: widget.position == SideMenuPosition.top
                      ? const EdgeInsets.symmetric(horizontal: 10)
                      : const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: getMenuBorderRadius(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  width: widget.position == SideMenuPosition.top
                      ? double.maxFinite
                      : _menuSize - 10,
                  height: widget.position == SideMenuPosition.top
                      ? _menuSize - 10
                      : double.maxFinite,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: widget.position == SideMenuPosition.top
                          ? Axis.horizontal
                          : Axis.vertical,
                      shrinkWrap: true,
                      itemCount: menuItemList.length,
                      itemBuilder: (context, index) {
                        final iconData = menuItemList[index];
                        return AnimatedScale(
                          scale: 1,
                          duration: const Duration(milliseconds: 800),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            child: Icon(
                              iconData,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: widget.position == SideMenuPosition.left
                      ? Alignment.centerRight
                      : widget.position == SideMenuPosition.right
                          ? Alignment.centerLeft
                          : Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('asdasd');
                      setState(() {
                        isOpen = !isOpen;
                        if (isOpen) {
                          transform = getOpenTransform();
                        } else {
                          transform = getCloseTransform();
                        }
                      });
                    },
                    child: Container(
                      width: 22,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        getIcon(isOpen),
                        color: Colors.white,
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

  BorderRadius getMenuBorderRadius() {
    return BorderRadius.only(
      topRight: widget.position == SideMenuPosition.left
          ? const Radius.circular(_menuCorcnerRadius)
          : Radius.zero,
      bottomRight: widget.position == SideMenuPosition.left ||
              widget.position == SideMenuPosition.top
          ? const Radius.circular(_menuCorcnerRadius)
          : Radius.zero,
      topLeft: widget.position == SideMenuPosition.right
          ? const Radius.circular(_menuCorcnerRadius)
          : Radius.zero,
      bottomLeft: widget.position == SideMenuPosition.right ||
              widget.position == SideMenuPosition.top
          ? const Radius.circular(_menuCorcnerRadius)
          : Radius.zero,
    );
  }

  Matrix4 getCloseTransform() {
    return widget.position == SideMenuPosition.left
        ? (Matrix4.identity()..translate(-_menuSize + 20))
        : widget.position == SideMenuPosition.right
            ? (Matrix4.identity()..translate(_menuSize - 20))
            : (Matrix4.identity()..translate(0.0, -(_menuSize - 20)));
  }

  Matrix4 getOpenTransform() {
    return Matrix4.identity();
  }

  IconData getIcon(bool isOpen) {
    return isOpen
        ? widget.position == SideMenuPosition.left
            ? Icons.chevron_left
            : widget.position == SideMenuPosition.right
                ? Icons.chevron_right
                : Icons.expand_less
        : widget.position == SideMenuPosition.left
            ? Icons.chevron_right
            : widget.position == SideMenuPosition.right
                ? Icons.chevron_left
                : Icons.expand_more;
  }
}
