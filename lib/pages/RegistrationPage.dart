import 'package:flutter/material.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:url_launcher/url_launcher.dart';
class RegistrationPage extends StatefulWidget
{
  const RegistrationPage({ Key? key }) : super(key: key);
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
class _RegistrationPageState extends State<RegistrationPage>
{
  Service service=Service();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      body:Center
      (
        child: Stack
        (
          alignment: Alignment.center,
          children:
          [
            const SizedBox
            (
              height: 600,
              width: 300,
              child:DecoratedBox
              (
                decoration: BoxDecoration
                (
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)) 
                )
              ),
            ),
            Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                const FlutterLogo(size: 60),
                const Text
                (
                  "Pastylla Store\nApp",
                  style: TextStyle
                  (
                    color: Color.fromRGBO(255, 194, 1, 1),
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text
                (
                  "Registrarse",
                  style: TextStyle
                  (
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox
                (
                  width: 250,
                  child: TextFormField
                  (
                    decoration: const InputDecoration
                    (
                      hintText: "Nombre de usuario",
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide
                        (
                          color: Colors.black
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox
                (
                  width: 250,
                  child: TextFormField
                  (
                    decoration: const InputDecoration
                    (
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide
                        (
                          color: Colors.black
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox
                (
                  width: 250,
                  child: TextFormField
                  (
                    obscureText: true,
                    decoration: const InputDecoration
                    (
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide
                        (
                          color: Colors.black
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text
                (
                  "Al finalizar el registro se\nesta aceptado la",
                  textAlign: TextAlign.center,
                ),
                GestureDetector
                (
                  onTap: ()async
                  {
                    Uri url=Uri.parse("https://shrub-almond-f38.notion.site/Pol-tica-de-privacidad-9867af0633af450b8cb8d4104d483fe5?pvs=4");
                    if(await canLaunchUrl(url))
                    {
                      await launchUrl(url);
                    }
                    else
                    {
                      throw 'No se pudo abrir la URL $url';
                    }
                  },
                  child: const Text
                  (
                    "Politica de Privacidad",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton
                (
                  onPressed: (){},
                  style:ElevatedButton.styleFrom
                  (
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white
                  ),
                  child: const Text("Registrarse")
                )
              ],
            )
          ],
        ),
      )
    );
  }
}