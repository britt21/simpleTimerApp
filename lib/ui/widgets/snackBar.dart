import 'package:flutter/material.dart';


class MyWidget extends StatelessWidget {
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
