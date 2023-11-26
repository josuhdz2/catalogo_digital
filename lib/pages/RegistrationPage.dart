import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  final TextEditingController userController=TextEditingController();
  final emailKey=GlobalKey<FormBuilderFieldState>();
  final passKey=GlobalKey<FormBuilderFieldState>();
  final userKey=GlobalKey<FormBuilderFieldState>();
  bool proceso=false;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      body:Center
      (
        child: ListView(
          children: 
          [
            Stack
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
                    Image.asset("assets/logo.jpg", height: 120),
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
                      "Registrate",
                      style: TextStyle
                      (
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox
                    (
                      key: const ValueKey("user"),
                      width: 250,
                      child: FormBuilderTextField
                      (
                        name: "user",
                        key:userKey,
                        controller: userController,
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
                        validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(errorText: "Este campo debe tener contenido."),
                          FormBuilderValidators.maxLength(20, errorText: "No debe superar 20 caracteres.")
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox
                    (
                      key: const ValueKey("email"),
                      width: 250,
                      child: FormBuilderTextField
                      (
                        name: "email",
                        key: emailKey,
                        controller: emailController,
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
                        validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(errorText: "Este campo debe tener contenido."),
                          FormBuilderValidators.email(errorText: "Ingresa un correo con formato valido")
                        ]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox
                    (
                      key: const ValueKey("pass"),
                      width: 250,
                      child: FormBuilderTextField
                      (
                        name: "pass",
                        key: passKey,
                        controller: passwordController,
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
                        validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(errorText: "Este campo debe tener contenido."),
                          FormBuilderValidators.minLength(8, errorText: "Debe tener al menos 8 caracteres.")
                        ]),
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
                    const SizedBox(height: 5),
                    proceso?const CircularProgressIndicator(color: Colors.black,):const SizedBox(height: 10),
                    const SizedBox(height: 5),
                    ElevatedButton
                    (
                      key: const ValueKey("registro"),
                      onPressed: () async
                      {
                        setState(() {
                          proceso=true;
                        });
                        if(!userKey.currentState!.validate() || !emailKey.currentState!.validate() || !passKey.currentState!.validate())
                        {
                          setState(() {
                            proceso=false;
                          });
                          return;
                        }
                        String email=emailController.text;
                        String username=userController.text;
                        String password=passwordController.text;
                        if(await service.registrarUser(username, email, password))
                        {
                          setState(() {
                            Navigator.pushNamed(context, '/login');
                          });
                        }
                        else
                        {
                          setState(() {
                            proceso=false;
                          });
                          Fluttertoast.showToast
                          (
                            msg: "El correo ya esta registrado. Inicia sesion.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM
                          );
                        }
                      },
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
            )
          ],
        ),
      )
    );
  }
}