import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

void showMyCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2), // Adjust the duration as needed
    backgroundColor: Colors.black87,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


class MySnackbar extends StatelessWidget {
  String message;

  MySnackbar({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final snackBar = SnackBar(
          content: Text('This is a Snackbar'),
          duration: Duration(seconds: 3), // Optional duration
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Perform some action when the user presses the action button
            },
          ),
        );

        // Show the Snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Text('Show Snackbar'),
    );
  }

}
