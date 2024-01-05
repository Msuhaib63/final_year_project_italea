import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';
import 'package:popover/popover.dart';

import 'Menu_items.dart';

AppBar NavBar(BuildContext context, String title, IconData icon) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    //automaticallyImplyLeading: false,
    elevation: 0.0,
    toolbarHeight: 75,
    flexibleSpace: Container(
        decoration: colorBackground1(context)
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: [
      IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          onPressed: () => showPopover(
            context: context,
            bodyBuilder: (context) => MenuItems(),
            width: 50,
            height: 50,
            direction: PopoverDirection.left,
          )
      )
    ],
  );
}