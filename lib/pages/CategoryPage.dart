import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/CategoryResultPage.dart';
import 'package:pastylla_client/pages/SearchPage.dart';
class CategoryPage extends StatefulWidget
{
  const CategoryPage({ Key? key }) : super(key: key);
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}
class _CategoryPageState extends State<CategoryPage>
{
  List<String> lista=["hola"];
  final TextEditingController busquedaController=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Padding
    (
      padding: const EdgeInsets.all(15.0),
      child: Column
      (
        children: <Widget>
        [
          TextFormField
          (
            controller: busquedaController,
            decoration: const InputDecoration
            (
              hintText: "Buscar producto",
              focusedBorder: OutlineInputBorder
              (
                borderSide: BorderSide(color: Colors.black)
              ),
              enabledBorder: OutlineInputBorder
              (
                borderSide: BorderSide(color: Colors.black)
              )
            ),
            onFieldSubmitted: (value)
            {
              Navigator.push
              (
                context,
                MaterialPageRoute(builder: (context)=>SearchPage(busqueda: busquedaController.text))
              );
            },
          ),
          const Padding
          (
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text
            (
              "Categorias",
              style: TextStyle
              (
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded
          (
            child: GridView.builder
            (
              itemCount: lista.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index)
              {
                return GestureDetector
                (
                  onTap: ()
                  {
                    Navigator.push
                    (
                      context,
                      MaterialPageRoute(builder: (context)=>CategoryResultPage(categoria: lista[index]))
                    );
                  },
                  child: Padding
                  (
                    padding: const EdgeInsets.all(10.0),
                    child: Container
                    (
                      decoration:BoxDecoration
                      (
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center
                      (
                        child: Text
                        (
                          lista[index],
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}