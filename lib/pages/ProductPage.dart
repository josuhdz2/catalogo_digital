import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:pastylla_client/widgets/MyAppBar.dart';
class ProductPage extends StatefulWidget
{
  final String id;
  const ProductPage({ Key? key, required this.id }) : super(key: key);
  @override
  State<ProductPage> createState() => _ProductPageState();
}
class _ProductPageState extends State<ProductPage>
{
  Map<String, dynamic> producto={};
  Service service=Service();
  @override
  void initState() {
    datosProducto();
    super.initState();
  }
  Future<void> datosProducto() async
  {
    service.infoProducto(widget.id).then((data)
    {
      setState(() {
        producto=data;
      });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar:MyAppBar(nombre: producto['nombre']),
      body: Column
      (
        children: <Widget>
        [
          SizedBox
          (
            height: MediaQuery.of(context).size.width,
            child: Swiper
            (
              itemCount: producto['imagenes'].length,
              itemBuilder: (context, index)
              {
                final image=producto['imagenes'][index];
                return Image.network
                (
                  "http://192.168.1.94:3000/images/$image",
                  fit: BoxFit.fill
                );
              },
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
            ),
          ),
          Padding
          (
            padding: const EdgeInsets.all(10),
            child: Column
            (
              children: <Widget>
              [
                Text
                (
                  producto['nombre'],
                  style: const TextStyle
                  (
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text
                (
                  "Marca: ${producto['marca']}",
                  style: const TextStyle
                  (
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}