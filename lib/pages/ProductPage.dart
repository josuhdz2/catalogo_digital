import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController comentarioController=TextEditingController();
  Map<String, dynamic> producto={};
  List<Map<String, dynamic>> comentarios=[];
  Service service=Service();
  bool favorito=false;
  bool carrito=false;
  @override
  void initState() {
    datosProducto();
    comentariosfunc();
    super.initState();
  }
  Future<void> datosProducto() async
  {
    service.infoProducto(widget.id).then((data)
    {
      setState(()
      {
        producto=data;
      });
    });
    service.verificarCarrito(widget.id).then((data)=>
    {
      setState(()
      {
        carrito=data;
      })
    });
    service.verificarFav(widget.id).then((data)=>
    {
      setState(()
      {
        favorito=data;
      })
    });
  }
  Future<void> comentariosfunc() async
  {
    service.comentarios(widget.id).then((data)=>
    {
      setState(()
      {
        comentarios=data;
      })
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar:MyAppBar(nombre: producto['nombre']),
      body: ListView
      (
        children: <Widget>
        [
          SizedBox
          (
            height: MediaQuery.of(context).size.width,
            child: Stack
            (
              alignment: Alignment.bottomRight,
              children:
              [
                Swiper
                (
                  itemCount: producto['imagenes'].length,
                  itemBuilder: (context, index)
                  {
                    final image=producto['imagenes'][index];
                    return Image.network
                    (
                      'https://firebasestorage.googleapis.com/v0/b/pastyllastorestorage.appspot.com/o/$image?alt=media',
                      fit: BoxFit.fill
                    );
                  },
                  pagination: const SwiperPagination(),
                  control: const SwiperControl(),
                ),
                IconButton
                (
                  onPressed: ()
                  {
                    service.agregarFav(producto['_id'])
                    .then((data)=>
                    {
                      setState(()
                      {
                        favorito=data;
                      })
                    });
                  },
                  icon: const Icon(Icons.favorite),
                  color: favorito?Colors.red:Colors.grey,
                )
              ],
            ),
          ),
          SizedBox
          (
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  Text
                  (
                    producto['nombre'],
                    style: const TextStyle
                    (
                      fontSize: 35.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text
                  (
                    "\$${producto['precio']}.00",
                    style: const TextStyle
                    (
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 5),
                  Row
                  (
                    children: <Widget>
                    [
                      const Text("Dispible"),
                      producto['estado']==true?const Icon(Icons.check_circle_outline_outlined,color: Colors.green):const Icon(Icons.cancel_outlined,color: Colors.red)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text
                  (
                    "Marca: ${producto['marca']}",
                    style: const TextStyle
                    (
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 10),
                  Text
                  (
                    "Tallas: ${producto['tallas']}",
                    style: const TextStyle
                    (
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 10),
                  const Text
                  (
                   "Descripcion:",
                    style: TextStyle
                    (
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 5),
                  Text
                  (
                    producto['descripcion'],
                    style: const TextStyle
                    (
                      fontSize: 15
                    ),
                  )
                ],
              ),
            ),
          ),
          Column
          (
            children:<Widget>
            [
              const Center
              (
                child: Text
                (
                  "Comentarios",
                  style: TextStyle
                  (
                    fontSize: 30
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              ListView.builder
              (
                shrinkWrap: true,
                itemCount: comentarios.length,
                itemBuilder: (context, index)
                {
                  return ListTile
                  (
                    leading: const Icon(Icons.person),
                    title: Text(comentarios[index]['username']),
                    subtitle: Text(comentarios[index]['comentarios']['contenido']),
                  );
                },
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField
                (
                  controller: comentarioController,
                  decoration: const InputDecoration
                  (
                    hintText: "Tu comentario",
                    focusedBorder: OutlineInputBorder
                    (
                      borderSide: BorderSide(color: Colors.black)
                    ),
                    enabledBorder: OutlineInputBorder
                    (
                      borderSide: BorderSide(color: Colors.black)
                    )
                  ),
                  onFieldSubmitted: (value) async
                  {
                    if(await service.comentar(producto['_id'], value))
                    {
                      comentariosfunc();
                    }
                    else
                    {
                      Fluttertoast.showToast
                      (
                        msg: "No se pudo realizar el comentario",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM
                     );
                    }
                    comentarioController.text="";
                  },
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: RawMaterialButton
      (
        onPressed: ()
        {
          service.agregarCarrito(producto['_id'])
          .then((data)=>
          {
            setState(()
            {
              carrito=data;
            })
          });
        },
        fillColor: carrito?Colors.yellow:Colors.black,
        shape: RoundedRectangleBorder
        (
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Text
        (
          carrito?'Agregado':'Agregar',
          style: TextStyle
          (
            color: carrito?Colors.black:Colors.white
          )
        )
      ),
      /*floatingActionButton: FloatingActionButton
      (
        onPressed: (){},
        child: const Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Icon(Icons.add), // Icono
            Text('Agregar al carrito'), // Texto dentro del botón
          ],
        )
      ),*/
    );
  }
}