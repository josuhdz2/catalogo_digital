import 'package:flutter/material.dart';
class Banner extends StatelessWidget
{
  final String nombreProducto;
  final String id;
  final String imageUrl;
  const Banner({ Key? key, required this.nombreProducto, required this.id, required this.imageUrl }) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      child: Stack
      (
        children:
        [
          Image.asset(""),
          const Text("Nombre del producto")
        ],
      ),
    );
  }
}