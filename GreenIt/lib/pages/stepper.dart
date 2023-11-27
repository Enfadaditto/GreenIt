import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:my_app/Models/Step.dart' as MyStep;

class MyStepper extends StatefulWidget {
  List<MyStep.Step?> steps;

  MyStepper({required this.steps});

  @override
  _MyStepper createState() => _MyStepper();
}

class _MyStepper extends State<MyStepper> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      scrollDirection: Axis.horizontal,
      builder: TimelineTileBuilder.fromStyle(
        oppositeContentsBuilder: (context, index) => index % 2 == 0 ? Padding(padding: EdgeInsets.all(8.0), child: Text("${widget.steps[index]!.getDescription()}", style: TextStyle(color: Colors.white))) : null,
        itemExtent: 100.0,
        indicatorStyle: IndicatorStyle.dot,
        addRepaintBoundaries: true,
        endConnectorStyle: ConnectorStyle.transparent,
        contentsAlign: ContentsAlign.basic,
        connectorStyle: ConnectorStyle.solidLine,
        contentsBuilder: (context, index) => index % 2 != 0 ? Padding(padding: EdgeInsets.all(8.0), child: Text("${widget.steps[index]!.getDescription()}", style: TextStyle(color: Colors.white))) : null,
        itemCount: widget.steps.length
      ),
    );
  }
}
