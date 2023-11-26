import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:pastylla_client/widgets/MyAppBar.dart';
class ShoppingCart extends StatefulWidget
{
  const ShoppingCart({ Key? key }) : super(key: key);
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}
class _ShoppingCartState extends State<ShoppingCart>
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
    service.carrito().then((data)=>
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
      appBar: const MyAppBar(nombre:"carrito"),
      body: ListView.builder
      (
        shrinkWrap: true,
        itemCount: lista.length,
        itemBuilder: (context, index)
        {
          var imagen='https://firebasestorage.googleapis.com/v0/b/pastyllastorestorage.appspot.com/o/${lista[index]['imagenes'][0]}?alt=media';
          return ListTile
          (
            leading: Image.network(imagen),
            title: Text(lista[index]['nombre']),
            subtitle: Text(lista[index]['descripcion']),
          );
        }
      ),
      floatingActionButton: RawMaterialButton
      (
        onPressed: ()
        {
          //vacio
        },
        fillColor:Colors.yellow,
        shape: RoundedRectangleBorder
        (
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: const Text
        (
          "Continuar",
          style: TextStyle
          (
            color: Colors.black
          )
        )
      ),
    );
  }
}