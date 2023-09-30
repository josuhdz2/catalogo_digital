import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget
{
  const LoginPage({ Key? key }) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>
{
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
              height: 500,
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
                const FlutterLogo(size: 60,),
                const Text
                (
                  "Pastylla Store\nApp",
                  style: TextStyle
                  (
                    color: Color.fromRGBO(255, 194, 1, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                SizedBox
                ( width: 250,
                  child: TextFormField
                  (
                    decoration: const InputDecoration
                    (
                      hintText: "Correo electronico",
                      focusedBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide
                        (
                          color: Colors.black
                        )
                      )
                    ),
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