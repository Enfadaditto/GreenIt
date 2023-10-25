import 'package:flutter/material.dart';
import 'package:my_app/Models/user.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/widgets/profile_page/profile_widget.dart';
import 'package:my_app/widgets/profile_page/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  User user;

  EditProfilePage({required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            // ProfileWidget(
            //   imagePath: user.imagePath,
            //   isEdit: true,
            //   onClicked: () async {},
            // ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: widget.user.displayName,
              onChanged: (displayName) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Email',
              text: widget.user.email,
              // maxLines: x,
              onChanged: (email) {},
            ),
          ],
        ),
      );
}
