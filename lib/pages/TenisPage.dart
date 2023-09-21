import 'package:flutter/material.dart';
class TenisPage extends StatefulWidget
{
  const TenisPage({ Key? key }) : super(key: key);
  @override
  State<TenisPage> createState() => _TenisPageState();
}
class _TenisPageState extends State<TenisPage>
{
  @override
  Widget build(BuildContext context)
  {
    return const Scaffold
    (
      body: Center
      (
        child: Text("hola pagina de tenis"),
      ),
    );
  }
}