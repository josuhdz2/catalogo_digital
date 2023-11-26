import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:pastylla_client/widgets/Banner.dart';
import 'package:pastylla_client/widgets/MyAppBar.dart';
class FavoritesPage extends StatefulWidget
{
  const FavoritesPage({ Key? key }) : super(key: key);
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}
class _FavoritesPageState extends State<FavoritesPage>
{
  List<Map<String, dynamic>> lista=[];
  Service service=Service();
  bool listaEstado=true;
  @override
  void initState()
  {
    peticion();
    super.initState();
  }
  Future<void> peticion() async
  {
    service.listaFavoritos().then((data)=>
    {
      if(data.isNotEmpty)
      {
        setState(()
        {
          lista=data;
        })
      }
      else
      {
        setState(()
        {
          listaEstado=false;
        })
      }
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: const MyAppBar(nombre:"Favoritos"),
      body: listaEstado?GridView.builder
      (
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: lista.length,
        itemBuilder: (context, index)
        {
          return BannerBuilder
          (
            nombre: lista[index]['nombre'],
            id: lista[index]['_id'],
            urlImage: lista[index]['imagenes'][0]
          );
        }
      ):const Text
      (
        key:ValueKey("vacio"),
        "No hay productos agregados",
        style: TextStyle
        (
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}