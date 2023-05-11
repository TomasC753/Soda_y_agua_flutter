import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  String error;
  ErrorMessage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.errorContainer,
      child: Text(
        error,
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
    );
  }
}
