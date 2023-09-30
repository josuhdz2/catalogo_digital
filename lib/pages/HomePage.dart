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
  Widget build(BuildContext context)
  {
    return const Column
    (
      children:
      [
        Text
        (
          "nombres del equipo",
          style: TextStyle
          (
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        Text("Diegod ya sabe usar git"),
        Text("Josue Hernandez Chavez"),
        Text("Alexandra Monserrath Gudiño Lucas"),
        Text("Hernandez Sanchez Jeronimo de Jesus")
      ],
    );
  }
}
