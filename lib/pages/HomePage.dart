import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  Service service=Service();
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
    return Column
    (
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        const Text
        (
          "nombres del equipo",
          style: TextStyle
          (
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        const Text("Diegod ya sabe usar git"),
        const Text("Josue Hernandez Chavez"),
        const Text("Alexandra Monserrath Gudiño Lucas"),
        const Text("Hernandez Sanchez Jeronimo de Jesus"),
        ElevatedButton
        (
          onPressed: () async
          {
            await service.logout();
            setState(() {
              Navigator.pushReplacementNamed(context, '/login');
            });
          },
          child: const Text("cerrar sesion")
        )
      ],
    );
  }
}
