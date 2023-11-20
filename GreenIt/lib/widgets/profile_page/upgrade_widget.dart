import 'package:flutter/material.dart';

class UpgradeDialog extends StatelessWidget {
  final VoidCallback onOkPressed;

  const UpgradeDialog({Key? key, required this.onOkPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'We are working on that',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Thank you for your interest. This feature is under development.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onOkPressed,
              child: const Text('Okay!'),
            ),
          ],
        ),
      ),
    );
  }
}
