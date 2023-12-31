import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget
{
  @override
  Size get preferredSize=>const Size.fromHeight(56.0);
  final String nombre;
  const MyAppBar({ Key? key, required this.nombre }) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return AppBar
    (
      leading: IconButton
      (
        key: const ValueKey("regresar"),
        icon: const Icon(Icons.arrow_back),
        onPressed: ()
        {
          Navigator.of(context).pop();
        }
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text
      (
        nombre,
        style: const TextStyle
        (
          color: Colors.yellow
        ),
      ),
    );
  }
}