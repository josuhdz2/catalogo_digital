import 'package:flutter/material.dart';
class InitialPage extends StatefulWidget
{
  const InitialPage({ Key? key }) : super(key: key);
  @override
  State<InitialPage> createState() => _InitialPageState();
}
class _InitialPageState extends State<InitialPage>
{
  @override
  Widget build(BuildContext context)
  {
    return const Column
    (
      children:
      [
        Text("Hola y bienvenidos a Pastylla Store App")
      ],
    );
  }
}