import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Service
{
  String baseURL="https://pastylla-store.onrender.com";
  Future<bool> agregarCarrito(id) async
  {
    final prefs=await SharedPreferences.getInstance();
    List<String>? listaCarrito=prefs.getStringList('carrito');
    listaCarrito??=[];
    if(listaCarrito.contains(id))
    {
      listaCarrito.remove(id);
      prefs.setStringList('carrito', listaCarrito);
      return false;
    }
    else
    {
      listaCarrito.add(id);
      prefs.setStringList('carrito', listaCarrito);
      return true;
    }
  }
  Future<bool> verificarCarrito(id) async
  {
    final prefs=await SharedPreferences.getInstance();
    List<String>? lista=prefs.getStringList('carrito');
    lista??=[];
    if(lista.contains(id))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  Future<List<Map<String, dynamic>>> carrito() async
  {
    final prefs=await SharedPreferences.getInstance();
    List<String>? listaCarrito=prefs.getStringList('carrito');
    if(listaCarrito!=null)
    {
      String listaIds=listaCarrito.join(",");
      final response=await http.post
      (
        Uri.parse('$baseURL/productos/prodCarritos'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body:{'lista':listaIds}
      );
      if(response.statusCode==200)
      {
        final data=json.decode(response.body);
        if(data['response']=='success')
        {
          return List<Map<String, dynamic>>.from(data['carrito']);
        }
        return [];
      }
      return [];
    }
    return [];
  }
  Future<List<Map<String, dynamic>>> listaFavoritos() async
  {
    final prefs=await SharedPreferences.getInstance();
    List<String>? favs=prefs.getStringList('favoritos');
    if(favs!=null)
    {
      String listaIds=favs.join(",");
      print(listaIds);
      final response=await http.post
      (
        Uri.parse('$baseURL/productos/favoritos'),
        headers: {'Content-Type':'application/x-www-form-urlencoded'},
        body:{'lista':listaIds}
      );
      if(response.statusCode==200)
      {
        final data=json.decode(response.body);
        if(data['response']=='success')
        {
          return List<Map<String, dynamic>>.from(data['lista']);
        }
      }
      else
      {
        return [];
      }
    }
    return [];
  }
  Future<bool> agregarFav(id) async
  {
    final prefs=await SharedPreferences.getInstance();
    List<String>? listafavs=prefs.getStringList('favoritos');
    listafavs??=[];
    if(listafavs.contains(id))
    {
      listafavs.remove(id);
      print("eliminado");
      prefs.setStringList('favoritos',listafavs);
      return false;
    }
    else
    {
      print("agregado");
      listafavs.add(id);
      prefs.setStringList('favoritos',listafavs);
      return true;
    }
  }
  Future<bool> verificarFav(id) async
  {
    final prefs=await SharedPreferences.getInstance();
    List<String>? lista=prefs.getStringList('favoritos');
    lista??=[];
    if(lista.contains(id))
    {
      print("ya esta en la lista");
      return true;
    }
    else
    {
      print('no esta en la lista');
      return false;
    }
  }
  Future<bool> comentar(productoId, mensaje) async
  {
    final prefs=await SharedPreferences.getInstance();
    final String? token=prefs.getString('token');
    if(token=='')
    {
      return false;
    }
    final response=await http.post
    (
      Uri.parse('$baseURL/usuario/comentar'),
      headers: {'Content-Type':'application/x-www-form-urlencoded', 'Authorization':token.toString()},
      body:{'productoId':productoId, 'comentario':mensaje}
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        return true;
      }
      return false;
    }
    return false;
  }
  Future<List<Map<String, dynamic>>> categoria(categoria) async
  {
    final response=await http.post
    (
      Uri.parse('$baseURL/productos/categoria'),
      headers: {'Content-Type':'application/x-www-form-urlencoded'},
      body:{'categoria':categoria}
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        return List<Map<String, dynamic>>.from(data['lista']);
      }
      return [];
    }
    else
    {
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> busqueda(busqueda) async
  {
    final response=await http.post
    (
      Uri.parse('$baseURL/productos/buscar'),
      headers: {'Content-Type':'application/x-www-form-urlencoded'},
      body:{'busqueda':busqueda}
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        return List<Map<String, dynamic>>.from(data['lista']);
      }
      return [];
    }
    else
    {
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> comentarios(id) async
  {
    final response=await http.get
    (
      Uri.parse('$baseURL/productos/comentarios/$id')
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        return List<Map<String, dynamic>>.from(data['comentarios']);
      }
      return [];
    }
    else
    {
      return [];
    }
  }
  Future<Map<String, dynamic>> infoProducto(id) async
  {
    final response=await http.get
    (
      Uri.parse('$baseURL/productos/infoProducto/$id')
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        return Map<String, dynamic>.from(data['producto']);
      }
      return {};
    }
    else
    {
      return {};
    }
  }
  Future<List<Map<String,dynamic>>> listaProductos() async
  {
    final response=await http.get
    (
      Uri.parse('$baseURL/productos/vistaGeneral')
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['lista']);
    }
    else
    {
      return [];
    }
  }
  Future<void> logout() async
  {
    final prefs=await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('favoritos');
    prefs.remove('carrito');
  }
  Future<dynamic> verify(bool datos) async
  {
    final prefs=await SharedPreferences.getInstance();
    final String? token=prefs.getString('token');
    if(token=='')
    {
      return false;
    }
    final response=await http.get
    (
      Uri.parse('$baseURL/usuario/info'),
      headers: {'Authorization':token.toString()}
    );
    if(response.statusCode==200)
    {
      final Map<String, dynamic> data=json.decode(response.body);
      if(data['response']=="success")
      {
        return datos?Map<String, dynamic>.from(data['userInfo']):true;
      }
      else
      {
        prefs.remove('token');
        return false;
      }
    }
    else
    {
      return false;
    }
  }
  Future<bool> actualizarUser(String user, String email) async
  {
    final prefs=await SharedPreferences.getInstance();
    final String? token=prefs.getString('token');
    if(token=='')
    {
      return false;
    }
    final response=await http.post
    (
      Uri.parse('$baseURL/usuario/modificarInfo'),
      headers: {'Content-Type':'application/x-www-form-urlencoded', 'Authorization':token.toString()},
      body: {'email':email, 'username':user}
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        return true;
      }
      print(data['error']);
      return false;
    }
    return false;
  }
  Future<bool> eliminarCuenta() async
  {
    final prefs=await SharedPreferences.getInstance();
    final String? token=prefs.getString('token');
    if(token=='')
    {
      return false;
    }
    final response=await http.get
    (
      Uri.parse('$baseURL/usuario/eliminarCuenta'),
      headers: {'Authorization':token.toString()},
    );
    if(response.statusCode==200)
    {
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        prefs.remove('token');
        prefs.remove('favoritos');
        prefs.remove('carrito');
        return true;
      }
      print(data['error']);
      return false;
    }
    return false;
  }
  Future<bool> registrarUser(String user, String email, String password) async
  {
    final response=await http.post
    (
      Uri.parse('$baseURL/usuario/registro'),
      headers: {'Content-Type':'application/x-www-form-urlencoded'},
      body:{'username':user, 'email':email, 'password':password}
    );
    if(response.statusCode==200)
    {
      print('solicitud con exito');
      final data=json.decode(response.body);
      if(data['response']=='success')
      {
        print('respuesta satisfactoria');
        return true;
      }
      print("la respuesta ${data['error']}");
      return false;
    }
    print('fallo solicitud');
    return false;
  }
  Future<bool> login(String user, String pass) async
  {
    final response=await http.post
    (
      Uri.parse('$baseURL/usuario/login'),
      headers: {'Content-Type':'application/x-www-form-urlencoded'},
      body:{'email':user, 'password':pass}
    );
    if(response.statusCode==200)
    {   
      final Map<String, dynamic> data = json.decode(response.body);
      if(data['response']=="success")
      {
        final prefs=await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      return false;
    }
  }
}