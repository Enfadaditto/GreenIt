import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerConnect {
  ServerConnect() {}

  //used to be Future<Map<String, dynamic>>
  Future<dynamic> fetchData(String url) async {
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

  void insertData(String url) async {
    int err = 0;
    try {
      final response = await http.get(Uri.parse(url));
      err = response.statusCode;
      if (response.statusCode == 200) {
        print("All G");
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      throw Exception('status Code: $err, Error: $e');
    }
  }
}
