import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Service
{
  String baseURL="http://192.168.137.151:3000";
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
      print('respuesta:$data["lista"]');
      return List<Map<String, dynamic>>.from(data['lista']);
    }
    else
    {
      print(response.statusCode);
      return [];
    }
  }
  Future<void> logout() async
  {
    final prefs=await SharedPreferences.getInstance();
    prefs.remove('token');
  }
  Future<bool> verify() async
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
        return true;
      }
      else
      {
        print(data['error']);
        prefs.remove('token');
        return false;
      }
    }
    else
    {
      return false;
    }
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