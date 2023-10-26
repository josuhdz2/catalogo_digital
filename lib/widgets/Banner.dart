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
    var medida=MediaQuery.of(context).size.width;
    medida=medida/2;
    medida=medida*0.8;
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
            'https://firebasestorage.googleapis.com/v0/b/pastyllastorestorage.appspot.com/o/$urlImage?alt=media',
            width: medida,
            height: medida,
          ),
          Padding
          (
            padding: const EdgeInsets.all(2.0),
            child: Text
            (
              "${nombre.substring(0,16)}...",
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}