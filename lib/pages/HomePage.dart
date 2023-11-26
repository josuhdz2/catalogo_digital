import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pastylla_client/services/Service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>
{
  final TextEditingController userController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final userKey=GlobalKey<FormBuilderFieldState>();
  final emailKey=GlobalKey<FormBuilderFieldState>();
  bool proceso=false;
  Map<String, dynamic> usuario={};
  Service service=Service();
  @override
  void initState() {
    obtenerInfoUser();
    super.initState();
  }
  Future _showConfirmationDialog()
  {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Estás seguro de continuar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Rechazar
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Aceptar
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
  Future<void> obtenerInfoUser() async
  {
    service.verify(true).then((data)
    {
      setState(() {
        usuario=data;
        userController.text=usuario['username'];
        emailController.text=usuario['email'];
      });
    })
    .catchError((onError)
    {
      setState(()
      {
        //se puede agregar la eliminacion como cierre de sesion
        Fluttertoast.showToast(msg: "La sesion ha vencido");
        Navigator.pushReplacementNamed(context, '/login');
      });
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView
      (
        children:
        [
          const Text
          (
            key:ValueKey("mensaje"),
            "Informacion de usuario",
            style: TextStyle
            (
              fontSize: 40
            ),
          ),
          const SizedBox(height: 20),
          const Text
          (
            "Nombre de usuario",
            style:TextStyle
            (
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
          FormBuilderTextField
          (
            name: "user",
            key: userKey,
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
              ),
              enabledBorder: OutlineInputBorder
              (
                borderSide: BorderSide
                (
                  color: Colors.black
                )
              ),
            ),
            validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(errorText: "Este campo debe tener contenido."),
              FormBuilderValidators.maxLength(20, errorText: "No debe superar 20 caracteres.")
            ]),
          ),
          const SizedBox(height: 20),
          const Text
          (
            "Correo electronico",
            style:TextStyle
            (
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
          FormBuilderTextField
          (
            name: "email",
            key: emailKey,
            controller: emailController,
            decoration: const InputDecoration
            (
              hintText: "Correo electronico",
              focusedBorder: OutlineInputBorder
              (
                borderSide: BorderSide
                (
                  color: Colors.black
                )
              ),
              enabledBorder: OutlineInputBorder
              (
                borderSide: BorderSide
                (
                  color: Colors.black
                )
              ),
            ),
            validator: FormBuilderValidators.compose(
            [
              FormBuilderValidators.required(errorText: "Este campo debe tener contenido."),
              FormBuilderValidators.email(errorText: "Ingresa un correo con formato valido")
            ]),
          ),
          const SizedBox(height: 20),
          ElevatedButton
          (
            onPressed:() async
            {
              setState(() {
                proceso=true;
              });
              if(!userKey.currentState!.validate() || !emailKey.currentState!.validate())
              {
                setState(() {
                  proceso=false;
                });
                return;
              }
              if(emailController.text!=usuario['email'] || userController.text!=usuario['username'])
              {
                if(await service.actualizarUser(userController.text, emailController.text))
                {
                  Fluttertoast.showToast(msg:"Informacion actualizada");
                }
                else
                {
                  Fluttertoast.showToast(msg: "Ha ocurrido un error al actualizar la informacion");
                }
              }
              else
              {
                Fluttertoast.showToast
                (
                  msg: "No hay informacion que actualizar"
                );
              }
            },
            style: const ButtonStyle
            (
              backgroundColor: MaterialStatePropertyAll(Colors.black)
            ),
            child: const Text("Actualizar informacion"),
          ),
          const SizedBox(height: 20),
          ElevatedButton
          (
            onPressed:() async
            {
              bool userConfirmed = await _showConfirmationDialog();
              if (userConfirmed)
              {
                // El usuario confirmó
                print('Usuario confirmó.');
                if(await service.eliminarCuenta())
                {
                  setState(() {
                    Navigator.pushReplacementNamed(context, '/');
                  });
                }
              }
            },
            style: const ButtonStyle
            (
              backgroundColor: MaterialStatePropertyAll(Colors.red)
            ),
            child: const Text("Eliminar cuenta"),
          ),
          const SizedBox(height: 30),
          const Text
          (
            "nombres del equipo",
            style: TextStyle
            (
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          const Text("Diegod ya sabe usar git"),
          const Text("Josue Hernandez Chavez"),
          const Text("Alexandra Monserrath Gudiño Lucas"),
          const Text("Hernandez Sanchez Jeronimo de Jesus"),
          ElevatedButton
          (
            key: const ValueKey("cerrarSesion"),
            onPressed: () async
            {
              await service.logout();
              setState(() {
                Navigator.pushReplacementNamed(context, '/login');
              });
            },
            child: const Text("cerrar sesion")
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
        ],
      ),
    );
  }
}
