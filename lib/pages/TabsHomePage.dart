import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/CategoryPage.dart';
import 'package:pastylla_client/pages/HomePage.dart';

class TabsHomePage extends StatelessWidget {
  const TabsHomePage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController
    (
      length: 3,
      child: Scaffold
      (
        appBar: AppBar
        (
          bottom: const TabBar
          (
            tabs:
            [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.info))
            ]
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text
          (
            "Pastylla Store",
            style: TextStyle
            (
              color: Colors.yellow
            ),
          ),
        ),
        body: const TabBarView
        (
          children:
          [
            CategoryPage(),
            HomePage()
          ],
        ),
      )
    );
  }
}