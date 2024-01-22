import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/user.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier()
      : super([
          User(
              name: "Vikas",
              phoneNumber: "6205280071",
              familyMemberCount: 5,
              address: "Ward 7"),
          User(
              name: "Raju",
              phoneNumber: "8763564523",
              familyMemberCount: 5,
              address: "Ward 10"),
        ]);

  void addNewMember(User member) {
    state = [...state, member];
  }

  List<User> filterUserByNameOrPhone(String query) {
    return List<User>.from(state)
        .where((User user) =>
            user.name.toLowerCase().contains(query.toLowerCase()) ||
            user.phoneNumber.contains(query))
        .toList();
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, List<User>>((ref) => UserNotifier());
