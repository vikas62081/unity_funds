import 'package:flutter/material.dart';

showSnakebar(BuildContext context, String title) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
    children: [
      Icon(
        Icons.check_circle_outline,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      const SizedBox(width: 8),
      Text(title)
    ],
  )));
}
