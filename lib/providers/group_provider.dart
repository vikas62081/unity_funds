import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/group.dart';

final local_image = File.fromUri(Uri.file(
    '/Users/vikas/Library/Developer/CoreSimulator/Devices/69A87E8E-6C24-4F16-A40A-7FFF861D0E7D/data/Containers/Data/Application/906CEAF1-A28A-4255-ABD4-BC42B9F84DFD/tmp/image_picker_12241DE9-8D59-4D34-8CA5-368AE7AAFAB4-58551-00000198E8484A26.jpg'));

class GroupNotifier extends StateNotifier<List<Group>> {
  GroupNotifier()
      : super([
          Group(
              name: "Chath puja",
              description: "Description",
              isDefault: true,
              eventDate: DateTime.now(),
              image: local_image),
          Group(
              name: "Diwali",
              description: "Let's organize good",
              isDefault: true,
              eventDate: DateTime(DateTime.now().day - 10),
              image: local_image)
        ]);

  void addNewGroup(Group group) {
    state = [...state, group];
    print(group.image);
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, List<Group>>((ref) => GroupNotifier());
