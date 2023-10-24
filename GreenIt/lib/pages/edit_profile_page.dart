import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/widgets/appbar_widget.dart';
import 'package:my_app/widgets/profile_page/profile_widget.dart';
import 'package:my_app/widgets/profile_page/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

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
            ProfileWidget(
              imagePath: widget.user.imagePath,
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Full Name',
              text: widget.user.name,
              onChanged: (name) {},
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
