import 'package:flutter/material.dart';
import 'package:my_app/pages/register/green_it_page.dart';
import 'package:my_app/pages/my_app_page.dart';
import 'package:my_app/utils/cache_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set initial values before running the app
  await CacheManager.setUsername('');
  await CacheManager.setEmail('');
  await CacheManager.setDarkMode(false);

  String username = await CacheManager.getUsername();

  print("USERNAME: $username");

  if (username.isNotEmpty) {
    runApp(MyApp(username: username, type: 'name'));
  } else {
    runApp(GreenItPage());
  }
}
