import 'package:flutter/material.dart';
import 'package:my_app/pages/post_page.dart';
import 'package:my_app/models/Step.dart' as mod;

class PostPreview extends StatefulWidget {
  PostPreview({required this.steps});

  List<mod.Step> steps;

  @override
  State<StatefulWidget> createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  @override
  Widget build(BuildContext context) {
    print(widget.steps[0].image);

    return PageView(
      children: List.generate(
        widget.steps.length,
        (index) => StepCard(
            widget.steps[index].description, widget.steps[index].image!),
      ),
    );
  }
}
