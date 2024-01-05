import 'package:flutter/material.dart';

import 'Database/localDB.dart';
import 'Widget/Bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    // MaterialApp is typically used at the root of the widget tree,
    // but it's not necessary for every page/screen
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      // Set the home page content to be the custom Bottom Bar widget
      home: WidgetBottomBar(),
    );
  }
}

