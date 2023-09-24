import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/TabsHomePage.dart';
import 'package:pastylla_client/pages/TenisPage.dart';
import 'package:pastylla_client/pages/homePage.dart';
void main()
{
  runApp
  (
   MaterialApp
   (
    title: "Pastylla Store",
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>const TabsHomePage(),
      '/tenis':(context)=>const TenisPage()
    },
   )
  );
}