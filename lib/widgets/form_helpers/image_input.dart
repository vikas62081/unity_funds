import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onBillImageChanged});
  final void Function(File bill) onBillImageChanged;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? pickedImage;

  void _pickImage(BuildContext context, ImageSource source) async {
    if (context.mounted) Navigator.of(context).pop();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
    widget.onBillImageChanged(pickedImage!);
  }

  void _showListToPickImage(BuildContext context) {
    showBottomModal(
        context, (ImageSource source) => _pickImage(context, source));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showListToPickImage(context),
      child: Container(
        width: double.infinity,
        height: 64,
        padding: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Theme.of(context).colorScheme.outline)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => _showListToPickImage(context),
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  color: Theme.of(context).colorScheme.primary,
                )),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                pickedImage == null
                    ? "Bill not selected"
                    : basename(pickedImage!.path),
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),

            // TextButton.icon(
            //     onPressed: () => _showListToPickImage(context),
            //     icon: const Icon(Icons.add_a_photo_outlined),
            //     label: Text(pickedImage == null ? "Camera" : "Change"))
          ],
        ),
      ),
    );
  }
}
