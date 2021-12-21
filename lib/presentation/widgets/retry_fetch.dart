import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetryPressed;
  const ErrorMessage({
    Key? key,
    required this.errorMessage,
    required this.onRetryPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage!,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: onRetryPressed,
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
            ),
            child: const Text('Reload'),
          )
        ],
      ),
    );
  }
}
