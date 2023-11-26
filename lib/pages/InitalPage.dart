import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:pastylla_client/widgets/Banner.dart';
class InitialPage extends StatefulWidget
{
  const InitialPage({ Key? key }) : super(key: key);
  @override
  State<InitialPage> createState() => _InitialPageState();
}
class _InitialPageState extends State<InitialPage>
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
    service.listaProductos().then((data)
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
    return GridView.builder
    (
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      padding: const EdgeInsets.all(10),
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
    );
  }
}