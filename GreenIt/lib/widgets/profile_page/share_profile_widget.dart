import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildShareButton(BuildContext context, String username) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Green color
        foregroundColor: Colors.white, // White text color
      ),
      onPressed: () => showShareDialog(context, username),
      child: const Text(
        'Share profile',
        style: TextStyle(color: Colors.white),
      ),
    );

void showShareDialog(BuildContext context, String username) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
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
                'Link Saved Successfully!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'The link to the profile has been saved to your device. You can use it by pasting.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Green color
                  foregroundColor: Colors.white, // White text color
                ),
                onPressed: () {
                  // TODO: Copy the link to the clipboard
                  Clipboard.setData(ClipboardData(
                      text: 'http://16.170.159.93/getUserByName?username=' +
                          username));

                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Okay!'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
