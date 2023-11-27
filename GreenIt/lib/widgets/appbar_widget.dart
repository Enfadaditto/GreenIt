import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/utils/cache_manager.dart';

AppBar buildAppBar(BuildContext context) {
  const iconSearch = CupertinoIcons.search;
  const iconOptions = CupertinoIcons.ellipsis;
  return AppBar(
      leading: BackButton(),
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
            ];
          },
          icon: const Icon(iconOptions),
        ),
      ]);
}
