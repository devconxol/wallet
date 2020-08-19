import 'package:flutter/material.dart';
import 'package:wallet/shared/bottom_tabs/tabs_item.dart';


class BottomTabs extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;
  const BottomTabs({Key key, this.currentIndex, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onChange(0),
              child: TabsItem(
                icon: Icons.home,
                title: "Home",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(1),
              child: TabsItem(
                icon: Icons.person,
                title: "User",
                isActive: currentIndex == 1,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onChange(2),
              child: TabsItem(
                icon: Icons.settings,
                title: "Settings",
                isActive: currentIndex == 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
