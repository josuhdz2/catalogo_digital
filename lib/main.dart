import 'package:flutter/material.dart';
import 'package:pastylla_client/pages/LoginPage.dart';
import 'package:pastylla_client/pages/RegistrationPage.dart';
import 'package:pastylla_client/pages/TabsHomePage.dart';
import 'package:pastylla_client/pages/TenisPage.dart';
import 'package:pastylla_client/services/Service.dart';
void main()
{
  runApp
  (
   MaterialApp
   (
    title: "Pastylla Store",
    home: const VerifySesion(),
    debugShowCheckedModeBanner: false,
    routes: {
      '/tabs':(context)=>const TabsHomePage(),
      '/tenis':(context)=>const TenisPage(),
      '/login':(context)=>const LoginPage(),
      '/signup':(context)=>const RegistrationPage()
    },
   )
  );
}
class VerifySesion extends StatefulWidget
{
  const VerifySesion({ Key? key }) : super(key: key);
  @override
  State<VerifySesion> createState() => _VerifySesionState();
}
class _VerifySesionState extends State<VerifySesion>
{
  Service service=Service();
  @override
  void initState() {
    super.initState();
    print("verificando sesion");
    llamarVerificacion();
  }
  Future<void> llamarVerificacion() async{
    if(await service.verify())
    {
      setState(()
      {
        Navigator.pushReplacementNamed(context, '/tabs');
      });
    }
    else
    {
      setState(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return const Scaffold
    (
      body: Center(child: CircularProgressIndicator())
    );
  }
}