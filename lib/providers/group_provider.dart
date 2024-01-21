import 'dart:convert';
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
              eventDate: DateTime.now(),
              image: local_image,
              totalExpenses: 13000,
              totalCollected: 0),
          Group(
              name: "Diwali",
              description: "Let's organize good",
              eventDate: DateTime(DateTime.now().day - 10),
              image: local_image,
              totalExpenses: 8000,
              totalCollected: 0)
        ]);

  void addNewGroup(Group group) {
    state = [...state, group];
    print(group.image);
  }

  void updateTotalExpenses(String groupId, double amount) {
    state = state.map((group) {
      if (group.id == groupId) {
        return Group.transactionalUpdate(
          id: group.id,
          name: group.name,
          description: group.description,
          eventDate: group.eventDate,
          createdAt: group.createdAt,
          image: group.image,
          totalCollected: group.totalCollected,
          totalExpenses: (group.totalExpenses! + amount),
        );
      } else {
        return group;
      }
    }).toList();
  }

  void updateTotalCollection(String groupId, double amount) {
    state = state.map((group) {
      if (group.id == groupId) {
        return Group.transactionalUpdate(
          id: group.id,
          name: group.name,
          description: group.description,
          eventDate: group.eventDate,
          createdAt: group.createdAt,
          image: group.image,
          totalCollected: (group.totalCollected! + amount),
          totalExpenses: group.totalExpenses,
        );
      } else {
        return group;
      }
    }).toList();
  }

  Group getGroupById(String id) {
    return state.where((element) => element.id == id).first;
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, List<Group>>((ref) => GroupNotifier());
