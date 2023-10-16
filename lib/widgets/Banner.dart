import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/ProductPage.dart';
class BannerBuilder extends StatelessWidget
{
  final String nombre;
  final String id;
  final String urlImage;
  const BannerBuilder({ Key? key, required this.nombre, required this.id, required this.urlImage }) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector
    (
      onTap:()
      {
        Navigator.push
        (
          context,
          MaterialPageRoute(builder: (context)=>ProductPage(id: id))
        );
      },
      child: Column
      (
        children: <Widget>
        [
          Image.network
          (
            'http://192.168.1.94:3000/images/$urlImage',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding
          (
            padding: const EdgeInsets.all(2.0),
            child: Text
            (
              nombre,
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}