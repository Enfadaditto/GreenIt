import 'package:flutter/material.dart';
import 'package:my_app/widgets/post_page/image_selector.dart';

class StepDialog extends StatelessWidget {
  final Widget child;
  final int stepNumber;
  final Function(String) childFunction;
  final Function() cancelFunction;
  final Function() addStepFunction;

  const StepDialog(
      {required this.child,
      required this.childFunction,
      required this.cancelFunction,
      required this.addStepFunction,
      required this.stepNumber});

  @override
  Widget build(BuildContext context) {
    TextEditingController _stepDescriptionController = TextEditingController();

    return AlertDialog(
      title: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF269A66),
            ),
            width: 25,
            height: 25,
            child: Text(
              '${stepNumber}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Step ${stepNumber}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ],
      ),
      content: Container(
        height: 324,
        child: Column(children: [
          PickImageDialog(
            onImageSelected: childFunction,
            child: Text(
              'Select image',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextField(
              controller: _stepDescriptionController,
              decoration: InputDecoration(labelText: 'Step description'),
            ),
          )
        ]),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: cancelFunction,
          child: Text(
            'Close',
            style: TextStyle(
              color: Color(0xFF269A66),
              fontSize: 18,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(120, 45),
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Color(0xFF269A66)),
                  borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Colors.white),
        ),
        ElevatedButton(
          onPressed: addStepFunction,
          child: Text(
            'Add Step',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Color(0xFF269A66)),
        ),
      ],
    );
  }
}
