import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unity_funds/widgets/utils/image_picker_option.dart';

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

showBottomModal(BuildContext context, Function onOptionSelect) {
  return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 4),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey,
              ),
              width: 100,
              height: 5,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImagePickerOption(
                  icon: Icons.camera_alt_outlined,
                  title: "Camera",
                  onTap: () => onOptionSelect(ImageSource.camera),
                ),
                const SizedBox(width: 24),
                ImagePickerOption(
                  icon: Icons.add_photo_alternate_outlined,
                  title: "Gallery",
                  onTap: () => onOptionSelect(ImageSource.gallery),
                )
              ],
            )
          ]),
        );
      });
}
