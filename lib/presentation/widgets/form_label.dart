import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String label;
  final bool isRequired;
  final TextAlign alignment;

  const FormLabel({
    Key? key,
    required this.label,
    this.isRequired = false,
    this.alignment = TextAlign.start,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: alignment,
      text: TextSpan(
        text: '$label ',
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: isRequired ? '*' : '',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
