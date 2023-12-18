import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/pages/register/welcome_page.dart';
import 'package:my_app/utils/cache_manager.dart';

// ! app bar for edit profile
AppBar buildAppBar(BuildContext context) {
  const iconSearch = CupertinoIcons.search;
  const iconOptions = CupertinoIcons.ellipsis;
  return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.green[700],
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(iconSearch),
          onPressed: () {},
        ),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.nightlight_round),
                  title: const Text('Dark Mode'),
                  onTap: () async {
                    bool currentDarkMode = await CacheManager.getDarkMode();
                    print("State before change $currentDarkMode");
                    await CacheManager.setDarkMode(!currentDarkMode);
                    Navigator.pop(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Off'),
                  onTap: () {
                    _logOff(context);
                  },
                ),
              ),
            ];
          },
          icon: const Icon(iconOptions),
        ),
      ]);
}

void _logOff(BuildContext context) async {
  // Clear all values in CacheManager
  await CacheManager.setUsername('');
  await CacheManager.setEmail('');
  await CacheManager.setUserId(-1);
  await CacheManager.setDarkMode(false);

  // Navigate to the log-in or home screen (replace with your desired destination)
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => WelcomePage())); // Replace with your route name
}
