import 'package:flutter/material.dart';
import 'package:my_app/pages/register/green_it_page.dart';
import 'package:my_app/pages/my_app_page.dart';
import 'package:my_app/utils/cache_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String username = await CacheManager.getUsername();

  if (username.isNotEmpty) {
    runApp(MyApp(username: username, type: 'name'));
  } else {
    runApp(GreenItPage());
  }
}
