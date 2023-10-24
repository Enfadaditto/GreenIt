import 'package:flutter/material.dart';
import 'package:my_app/Models/notUser.dart';
import 'package:my_app/utils/user_preferences.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/widgets/profile_page/profile_widget.dart';
import 'package:my_app/widgets/profile_page/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  notUser user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              imagePath: user.imagePath,
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: user.name,
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: user.email,
              // maxLines: x,
              onChanged: (email) {},
            ),
          ],
        ),
      );
}
