import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/CategoryPage.dart';
import 'package:pastylla_client/pages/FavoritesPage.dart';
import 'package:pastylla_client/pages/HomePage.dart';
import 'package:pastylla_client/pages/InitalPage.dart';
import 'package:pastylla_client/pages/ShoppingCart.dart';

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
          actions:
          [
            IconButton
            (
              onPressed: ()
              {
                Navigator.push
                (
                  context,
                  MaterialPageRoute(builder: (context)=>const FavoritesPage())
                );
              },
              icon: const Icon(Icons.favorite),
              color: Colors.yellow,
            ),
            IconButton
            (
              onPressed: ()
              {
                Navigator.push
                (
                  context,
                  MaterialPageRoute(builder: (context)=>const ShoppingCart())
                );
              },
              icon: const Icon(Icons.shopping_bag_rounded),
              color: Colors.yellow,
            )
          ],
          bottom: const TabBar
          (
            tabs:
            [
              Tab(icon: Icon(Icons.home)),
              Tab(icon:Icon(Icons.menu)),
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
            InitialPage(),
            CategoryPage(),
            HomePage()
          ],
        ),
      )
    );
  }
}