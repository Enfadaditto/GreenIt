import 'package:flutter/material.dart';
import 'package:my_app/models/Post.dart';
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
    return PageView(
      children: List.generate(
        widget.steps.length,
        (index) => StepCard(widget.steps[index].description,
            'https://img.freepik.com/vector-gratis/ilustracion-icono-dibujos-animados-fruta-manzana-concepto-icono-fruta-alimentos-aislado-estilo-dibujos-animados-plana_138676-2922.jpg?w=2000'),
      ),
    );
  }
}
