import 'package:flutter/material.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
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
      return FlutterStepIndicator(
        onChange: (index) {
          _currentStep = index;
        },
        list: widget.steps,
        page: _currentStep,
        disableAutoScroll: false,
        height: 15,
      );
      /* return Timeline.tileBuilder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 12.0, bottom: 16.0),
      scrollDirection: Axis.horizontal,
      builder: TimelineTileBuilder.fromStyle(
        oppositeContentsBuilder: (context, index) => index % 2 == 0 ? Padding(padding: EdgeInsets.all(6.0), child: Text("${widget.steps[index]!.getDescription()}", style: TextStyle(color: Colors.white, fontSize: 8.0))) : null,
        itemExtent: 100.0,
        indicatorStyle: IndicatorStyle.dot,
        addRepaintBoundaries: true,
        endConnectorStyle: ConnectorStyle.transparent,
        contentsAlign: ContentsAlign.basic,
        connectorStyle: ConnectorStyle.solidLine,
        contentsBuilder: (context, index) => index % 2 != 0 ? Padding(padding: EdgeInsets.all(6.0), child: Text("${widget.steps[index]!.getDescription()}", style: TextStyle(color: Colors.white, fontSize: 8.0))) : null,
        itemCount: widget.steps.length,
      ),
    ); */
    
  }
}
