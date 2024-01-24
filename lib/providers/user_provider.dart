import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/providers/transaction_provider.dart';

class UserNotifier extends StateNotifier<List<User>> {
  late TransactionNotifier transactionNotifier = TransactionNotifier();
  UserNotifier() : super([]);

  Future<List<User>> getUsers() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    final List<User> users =
        querySnapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
    state = users;
    return users;
  }

  Future<void> addUser(User newUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add(newUser.toFirestore());
    state = [...state, newUser];
  }

  Future<User> getUserById(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    return User.fromFirestore(response);
  }

  Future<User> getActiveUser() {
    return getUserById("BT9kGjosqu1kQ1LcczKz");
  }

  Future<void> updateUserById(String id, User user,
      {bool hasUserNameChanged = false}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(user.toFirestore());
    _updateUserInProvider(id, user);

//batch to update all transactions by contributor id
    if (hasUserNameChanged) {
      transactionNotifier.updateTransContributorNameByContId(id, user.name);
    }
  }

  User _updateUserInProvider(String userId, User user) {
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
