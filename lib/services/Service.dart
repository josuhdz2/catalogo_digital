import 'dart:convert';
import 'package:http/http.dart' as http;
class Service
{
  String baseURL="http://localhost:3000";
  Future<dynamic> get(String endpoint) async
  {
    final response=await http.get(Uri.parse('$baseURL/$endpoint'));
    if(response.statusCode==200)
    {
      return jsonDecode(response.body);
    }
    else
    {
      throw Exception('Error al realizar la solicitud: ${response.statusCode}');
    }
  }
}