import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/group.dart';

final local_image = File.fromUri(Uri.file(
    '/Users/vikas/Library/Developer/CoreSimulator/Devices/69A87E8E-6C24-4F16-A40A-7FFF861D0E7D/data/Containers/Data/Application/104AB1B2-1D9D-4272-BDCB-CDD16BA88DDD/tmp/image_picker_42562124-C2A7-4F37-B576-3669D014C4A5-75316-000001B26694A5A7.jpg'));

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
