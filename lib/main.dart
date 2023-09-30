import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/LoginPage.dart';
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
    initialRoute: '/login',
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>const TabsHomePage(),
      '/tenis':(context)=>const TenisPage(),
      '/login':(context)=>const LoginPage()
    },
   )
  );
}