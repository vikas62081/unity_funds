import 'package:flutter/material.dart';

class ImagePickerOption extends StatelessWidget {
  const ImagePickerOption(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                Theme.of(context).colorScheme.inversePrimary.withOpacity(.25)),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(title)
          ],
        ),
      ),
    );
  }
}
