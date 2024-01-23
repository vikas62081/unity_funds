import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/user.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier()
      : super([
          User(
              name: "Vikas",
              phoneNumber: "6205280071",
              familyMemberCount: 5,
              address: "Ward 7",
              email: "vikas620@gmail.com",
              defaultGroupName: "Diwali"),
          User(
              name: "Raju",
              phoneNumber: "8763564523",
              familyMemberCount: 5,
              address: "Ward 10"),
        ]);

  User addNewUser(User user) {
    state = [...state, user];
    return user;
  }

  User getActiveUser() {
    return state[0];
  }

  User updateUser(String userId, User user) {
    state = List<User>.from(state)
        .map((User e) => e.id == userId ? user : e)
        .toList();
    return user;
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
