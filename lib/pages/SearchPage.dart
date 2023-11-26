import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:pastylla_client/widgets/Banner.dart';
import 'package:pastylla_client/widgets/MyAppBar.dart';
class SearchPage extends StatefulWidget
{
  final String busqueda;
  const SearchPage({ Key? key, required this.busqueda }) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage>
{
  List<Map<String,dynamic>> lista=[];
  Service service=Service();
  @override
  void initState()
  {
    peticion();
    super.initState();
  }
  Future<void> peticion()async
  {
    service.busqueda(widget.busqueda).then((data)
    {
      setState(()
      {
        lista=data;
        print('lista de productos: $lista');
      });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: const MyAppBar(nombre: "Resultado de busqueda"),
      body: GridView.builder
      (
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: lista.length,
        itemBuilder: (context, index)
        {
          print(lista[index]);
          return BannerBuilder
          (
            urlImage: lista[index]['imagenes'][0],
            nombre: lista[index]['nombre'],
            id: lista[index]['_id']
          );
        }
      ),
    );
  }
}
