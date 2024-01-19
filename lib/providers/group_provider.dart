import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/group.dart';

class GroupNotifier extends StateNotifier<List<Group>> {
  GroupNotifier() : super([]);

  void addNewGroup(Group group) {
    state = [...state, group];
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, List<Group>>((ref) => GroupNotifier());
