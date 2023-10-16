import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:pastylla_client/widgets/Banner.dart';
import 'package:pastylla_client/widgets/MyAppBar.dart';
class CategoryResultPage extends StatefulWidget
{
  final String categoria;
  const CategoryResultPage({ Key? key, required this.categoria }) : super(key: key);
  @override
  State<CategoryResultPage> createState() => _CategoryResultPageState();
}
class _CategoryResultPageState extends State<CategoryResultPage>
{
  List<Map<String, dynamic>> lista=[];
  Service service=Service();
  @override
  void initState()
  {
    peticion();
    super.initState();
  }
  Future<void> peticion()async
  {
    service.categoria(widget.categoria).then((data)
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
      appBar: MyAppBar(nombre: widget.categoria),
      body:GridView.builder
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