import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Service
{
  String baseURL="http://127.0.0.1:3000/usuario";
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
      Uri.parse('http://192.168.1.94:3000/usuario/info'),
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
      Uri.parse('http://192.168.1.94:3000/usuario/login'),
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