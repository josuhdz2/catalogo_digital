import 'package:flutter_driver/flutter_driver.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
void main()
{
  const url='http://127.0.0.1:50624/fKxuLJuUNH8=/';
  var faker=Faker();
  group('Realizacion de pruebas unitarias',()
  {
    late FlutterDriver driver;
    setUpAll(() async
    {
      driver=await FlutterDriver.connect(dartVmServiceUrl:url);
    });
    tearDownAll(() async
    {
      await driver.close();
    });
    test('Verificando validaciones (!email&&!pass)', () async
    {
      final boton=find.byValueKey('iniciarSesion');
      final pass=find.byValueKey('pass');
      final email=find.byValueKey('email');
      await driver.tap(email);
      await driver.enterText("");
      await driver.tap(pass);
      await driver.enterText("");
      driver.tap(boton);
      final mensajeFinder=find.text('Este campo debe tener contenido.');
      await driver.waitFor(mensajeFinder);
      expect(await driver.getText(mensajeFinder), 'Este campo debe tener contenido.');
    });
    test('Verificando validaciones (?email)', () async
    {
      final boton=find.byValueKey('iniciarSesion');
      final email=find.byValueKey('email');
      await driver.tap(email);
      await driver.enterText("Johanna30@hotmail");
      await driver.tap(boton);
      final mensajeFinder=find.text('Ingresa un correo con formato valido');
      await driver.waitFor(mensajeFinder);
      expect(await driver.getText(mensajeFinder), 'Ingresa un correo con formato valido');
    });
    test('Verificando validaciones (?pass)', () async
    {
      final boton=find.byValueKey("iniciarSesion");
      final pass=find.byValueKey('pass');
      final email=find.byValueKey('email');
      await driver.tap(email);
      await driver.enterText("Johanna30@hotmail.com");
      await driver.tap(pass);
      await driver.enterText("1234");
      await driver.tap(boton);
      final mensajeFinder=find.text('Debe tener al menos 8 caracteres.');
      await driver.waitFor(mensajeFinder);
      expect(await driver.getText(mensajeFinder), 'Debe tener al menos 8 caracteres.');
    });
    test('Verificar accesibilidad a la pantalla de registro', () async
    {
      final enlace=find.byValueKey("crearCuentaLink");
      await driver.tap(enlace);
      final nuevoElementoFinder = find.text('Registrate');
      await driver.waitFor(nuevoElementoFinder);
      expect(await driver.getText(nuevoElementoFinder), 'Registrate');
    });
    test('Verificar validaciones de registro (!username&&!email&&!pass)', () async
    {
      final boton=find.byValueKey('registro');
      final user=find.byValueKey('user');
      final email=find.byValueKey('email');
      final pass=find.byValueKey('pass');
      await driver.tap(user);
      await driver.enterText("");
      await driver.tap(email);
      await driver.enterText("");
      await driver.tap(pass);
      await driver.enterText("");
      await driver.tap(boton);
      final mensajeFinder=find.text('Este campo debe tener contenido.');
      await driver.waitFor(mensajeFinder);
      expect(await driver.getText(mensajeFinder), 'Este campo debe tener contenido.');
    });
    test('Verificar validaciones de registro (?username)', () async
    {
      final boton=find.byValueKey('registro');
      final user=find.byValueKey('user');
      await driver.tap(user);
      await driver.enterText("esteesuntextodemaciadolargo");
      await driver.tap(boton);
      final mensajeFinder=find.text('No debe superar 20 caracteres.');
      await driver.waitFor(mensajeFinder);
      expect(await driver.getText(mensajeFinder), 'No debe superar 20 caracteres.');
    });
  });
  group('Realizacion de pruebas de integracion', ()
  {
    late FlutterDriver driver;
    setUpAll(() async
    {
      driver=await FlutterDriver.connect(dartVmServiceUrl:url);
    });
    tearDownAll(() async
    {
      await driver.close();
    });
    test('Caso de uso: Verificar registro de usuario', () async
    {
      final boton=find.byValueKey("registro");
      final user=find.byValueKey('user');
      final email=find.byValueKey('email');
      final pass=find.byValueKey('pass');
      await driver.tap(user);
      await driver.enterText(faker.internet.userName());
      await driver.tap(email);
      await driver.enterText(faker.internet.email());
      await driver.tap(pass);
      await driver.enterText("12345678");
      await driver.tap(boton);
      final nuevoElementoFinder = find.text('Iniciar sesion');
      await driver.waitFor(nuevoElementoFinder);
      expect(await driver.getText(nuevoElementoFinder), 'Iniciar sesion');
    });
    test('Caso de uso: Verificar ingreso de informacion correcta', () async
    {
      final boton=find.byValueKey('iniciarSesion');
      final email=find.byValueKey("email");
      final pass=find.byValueKey("pass");
      await driver.tap(email);
      await driver.enterText("Johanna30@hotmail.com");
      await driver.tap(pass);
      await driver.enterText("12345678");
      await driver.tap(boton);
      final mensajeToastFinder=find.byValueKey('titulo');
      await driver.waitFor(mensajeToastFinder);
      expect(await driver.getText(mensajeToastFinder), 'Pastylla Store');
      //Jordan 1 Retro High Turbo Green
    });
    //experimentales
    test('Caso de uso: Verificar accesibilidad a la informacion del producto', () async
    {
      await Future.delayed(const Duration(seconds: 5));
      final boton=find.byValueKey('6534b73bdfb8d5f1cfac7da6');
      await driver.tap(boton);
      await Future.delayed(const Duration(seconds: 5));
      final mensaje=find.text("Disponible");
      await driver.waitFor(mensaje);  
      expect(await driver.getText(mensaje), "Disponible");
    });
    test("Caso de uso: Verificar agregacion a favoritos", () async
    {
      final boton=find.byValueKey("agregarFav");
      await driver.tap(boton);
      final regresar=find.byValueKey('regresar');
      await driver.tap(regresar);
      final favs=find.byValueKey("favPage");
      await driver.tap(favs);
      await Future.delayed(const Duration(seconds: 5));
      final prod=find.byValueKey('6534b73bdfb8d5f1cfac7da6');
      await driver.waitFor(prod);
      expect(await driver.getText(prod), "Jordan 1 Retro H...");
    });
    test("Caso de uso: Verificacion de eliminacion de favoritos", () async
    {
      var prod=find.byValueKey('6534b73bdfb8d5f1cfac7da6');
      await driver.tap(prod);
      final boton=find.byValueKey("agregarFav");
      await driver.tap(boton);
      var regresar=find.byValueKey("regresar");
      await driver.tap(regresar);
      regresar=find.byValueKey("regresar");
      await driver.tap(regresar);
      final favs=find.byValueKey("favPage");
      await driver.tap(favs);
      await Future.delayed(const Duration(seconds: 5));
      //no debe aver nada
      final lista=find.byValueKey("vacio");
      await driver.waitFor(lista);
      expect(await driver.getText(lista), "No hay productos agregados");
    });
    test("Caso de uso: Funcionamiento de tabs (menu)", () async
    {
      var regresar=find.byValueKey("regresar");
      await driver.tap(regresar);
      final menu=find.byValueKey("menu");
      await driver.tap(menu);
      final mensaje=find.byValueKey("mensaje");
      await driver.waitFor(mensaje);
      expect(await driver.getText(mensaje), "Categorias");
    });
    test("Caso de uso: Funcionamiento de tabs (info)", () async
    {
      final info=find.byValueKey("info");
      await driver.tap(info);
      final mensaje=find.byValueKey("mensaje");
      await driver.waitFor(mensaje);
      expect(await driver.getText(mensaje), "Informacion de usuario");
    });
    test("Caso de uso: Verificar cierre de sesion", () async
    {
      final boton=find.byValueKey("cerrarSesion");
      await driver.tap(boton);
      final nuevoElementoFinder = find.text('Iniciar sesion');
      await driver.waitFor(nuevoElementoFinder);
      expect(await driver.getText(nuevoElementoFinder), 'Iniciar sesion');
    });
  });
}