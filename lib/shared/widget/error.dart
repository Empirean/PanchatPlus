import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({Key? key, required this.errorText}) : super(key: key);

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
      child: ListTile(
        title: Text(errorText,
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
