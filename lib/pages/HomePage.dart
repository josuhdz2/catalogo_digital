import 'dart:html';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*@override
  void initState()
  {
    super.initState();
    //obtenerRecientes();
  }
  void obtenerRecientes() async
  {
    try
    {
      final data=await Service().get('/obtenerRecientes');
    }
    catch(e)
    {
      print("error en la solicitud");
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "Pastylla Store",
            style: TextStyle(color: Colors.yellow),
          ),
        ),
        body: const Column(
          children: [
            Text("nombres del equipo"),
            Text("Hernandez Sanchez Jeronimo de Jesus")
          ],
        ));
  }
}
