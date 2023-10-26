import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pastylla_client/services/Service.dart';
class LoginPage extends StatefulWidget
{
  const LoginPage({ Key? key }) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>
{
  Service service=Service();
  void nextPage()
  {
    Navigator.pushReplacementNamed(context, '/tabs');
  }
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final emailKey=GlobalKey<FormBuilderFieldState>();
  final passKey=GlobalKey<FormBuilderFieldState>();
  bool proceso=false;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.black,
      body: Center
      (
        child: Stack
        (
          alignment: Alignment.center,
          children:
          [
            const SizedBox
            (
              height: 550,
              width: 300,
              child: DecoratedBox
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
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text
                (
                  "Iniciar sesion",
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
                  width: 250,
                  child: FormBuilderTextField
                  (
                    name: "password",
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
                const SizedBox(height: 5),
                proceso?const CircularProgressIndicator(color: Colors.black,):const SizedBox(height: 10),
                const SizedBox(height: 5),
                ElevatedButton
                (
                  onPressed: () async
                  {
                    setState(() {
                      proceso=true;
                    });
                    if(!emailKey.currentState!.validate() || !passKey.currentState!.validate())
                    {
                      setState(() {
                        proceso=false;
                      });
                      return;
                    }
                    String email=emailController.text;
                    String password=passwordController.text;
                    if(await service.login(email, password))
                    {
                      nextPage();
                    }
                    else
                    {
                      setState(() {
                        proceso=false;
                      });
                      Fluttertoast.showToast
                      (
                        msg: "La informacion es incorrecta",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM
                      );
                      emailController.text="";
                      passwordController.text="";
                    }
                  },
                  style:ElevatedButton.styleFrom
                  (
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white
                  ),
                  child: const Text("Iniciar")
                ),
                const SizedBox(height: 20),
                const Text("No tienes una cuenta?"),
                GestureDetector
                (
                  onTap: ()
                  {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text
                  (
                    "Crear una cuenta",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}