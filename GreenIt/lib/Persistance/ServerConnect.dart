import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerConnect {

  ServerConnect(){}

  Future<Map<String, dynamic>> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response and return it as a formatted string
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void insertData(String url) async{
    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("All G");
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e){
      throw Exception('Error: $e');
    }
  }
  
}

