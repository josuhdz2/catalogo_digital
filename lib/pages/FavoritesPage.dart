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
      setState(()
      {
        lista=data;
      })
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: const MyAppBar(nombre:"Favoritos"),
      body: GridView.builder
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
      ),
    );
  }
}