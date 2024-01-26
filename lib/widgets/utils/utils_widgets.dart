import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:unity_funds/screens/profile/edit_profile_image.dart';
import 'package:unity_funds/widgets/utils/image_picker_option.dart';

showSnackbar(BuildContext context, String title) {
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
      showDragHandle: true,
      builder: (ctx) {
        return SizedBox(
          height: 200,
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black54),
    );
  }
}

Widget buildTextField(
    {required BuildContext context,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    Function(String?)? onSaved,
    TextInputType? keyboardType,
    String? prefixText,
    String? initialValue,
    bool enabled = true}) {
  return TextFormField(
    enabled: enabled,
    initialValue: initialValue,
    decoration: InputDecoration(
      hintText: hintText,
      prefixText: prefixText,
      prefixIcon: Icon(
        icon,
        color: enabled ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
      border: const OutlineInputBorder(),
    ),
    textCapitalization: TextCapitalization.sentences,
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );
}

Widget buildSaveButton(
    {required BuildContext context,
    required void Function()? onPressed,
    bool isLoading = false}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Theme.of(context).colorScheme.primaryContainer,
      ),
      fixedSize: MaterialStateProperty.all(
        const Size(double.maxFinite, 60),
      ),
    ),
    onPressed: isLoading ? null : onPressed,
    child: isLoading ? const CircularProgressIndicator() : const Text("Save"),
  );
}

Widget buildSearchableDropdown(
    {required BuildContext context,
    required IconData? icon,
    required String? hintText,
    dynamic initialSelection,
    bool enabled = true,
    void Function(dynamic)? onSelected,
    int reduceWidth = 48,
    required List<DropdownMenuEntry<dynamic>> items}) {
  return DropdownMenu(
    initialSelection: initialSelection,
    enabled: enabled,
    width: MediaQuery.of(context).size.width - reduceWidth,
    leadingIcon: Icon(
      icon,
      color: Theme.of(context).colorScheme.primary,
    ),
    hintText: hintText,
    requestFocusOnTap: true,
    enableFilter: true,
    onSelected: onSelected,
    dropdownMenuEntries: items,
  );
}

Widget buildFloatingActionButton(
    {required void Function()? onPressed, required String label}) {
  return FloatingActionButton.extended(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(120))),
      label: Row(
        children: [
          const Icon(Icons.add),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      onPressed: onPressed);
}

Widget buildProfileAvatar(
    {bool isEditable = false,
    required void Function(File image) onImageChanged,
    File? localImageFile,
    String? imageUrl}) {
  Widget buildImageRenderer() {
    if (localImageFile != null) {
      return FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: FileImage(localImageFile),
        fit: BoxFit.cover,
        height: 250,
        width: double.infinity,
      );
    }
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      image: NetworkImage(imageUrl!),
      fit: BoxFit.cover,
      height: 250,
      width: double.infinity,
    );
  }

  Widget buildImage() {
    if (imageUrl != null || localImageFile != null) {
      return ClipOval(
        child: buildImageRenderer(),
      );
    } else {
      return const Icon(Icons.person, size: 64);
    }
  }

  Widget buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: CircleAvatar(
        radius: 52,
        child: buildImage(),
      ),
    );
  }

  Widget buildEditButton() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Tooltip(
          message: 'Change Photo',
          child: EditProfileImage(onImageChanged: onImageChanged)),
    );
  }

  return Stack(
    children: [
      buildAvatar(),
      if (isEditable) buildEditButton(),
    ],
  );
}
