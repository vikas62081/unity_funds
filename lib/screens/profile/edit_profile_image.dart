import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({
    Key? key,
    required this.onImageChanged,
  }) : super(key: key);

  final void Function(File image) onImageChanged;

  @override
  State<EditProfileImage> createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  File? pickedImage;

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    Navigator.of(context).pop();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: source, imageQuality: 50, maxWidth: 200, maxHeight: 200);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
    widget.onImageChanged(pickedImage!);
  }

  void _showListToPickImage(BuildContext context) {
    showBottomModal(
      context,
      (ImageSource source) => _pickImage(context, source),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => _showListToPickImage(context),
        icon: const Icon(
          Icons.photo_camera,
          // color: Theme.of(context).colorScheme.primary,
        ));
  }
}
