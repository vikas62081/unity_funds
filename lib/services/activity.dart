import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unity_funds/modals/activity.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/user_provider.dart';

class ActivityService {
  final _firestore = FirebaseFirestore.instance.collection('activities');
  UserNotifier userNotifier = UserNotifier();

  Stream<QuerySnapshot<Map<String, dynamic>>> getActivity() {
    return _firestore.snapshots();
  }

  Future<void> addActivity(Activity activity) async {
    _firestore.add(activity.toFirestore());
  }

  Future<void> addNewUser(String newUsername) async {
    User user = await userNotifier.getActiveUser();
    final activity = Activity.user(createdBy: user.name, newUser: newUsername);
    addActivity(activity);
  }

  Future<void> addNewGroup(String name) async {
    User user = await userNotifier.getActiveUser();
    final activity = Activity.group(createdBy: user.name, groupName: name);
    addActivity(activity);
  }

  Future<void> addCreditActivity(
      {required String username,
      required double amount,
      required String groupName}) async {
    User user = await userNotifier.getActiveUser();
    final activity = Activity.credit(
        createdBy: user.name,
        groupName: groupName,
        amount: amount,
        contributorName: username);
    addActivity(activity);
  }

  Future<void> addDebitActivity(
      {required String expense,
      required double amount,
      required String groupName}) async {
    User user = await userNotifier.getActiveUser();
    final activity = Activity.debit(
        createdBy: user.name,
        groupName: groupName,
        amount: amount,
        expense: expense);
    addActivity(activity);
  }
}
