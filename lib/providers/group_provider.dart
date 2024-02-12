import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/services/activity.dart';
import 'package:unity_funds/services/storage.dart';

var db = FirebaseFirestore.instance;

class GroupNotifier extends StateNotifier<List<Group>> {
  StorageService storageHelper = StorageService();
  GroupNotifier() : super([]);

  Future<List<Group>> getGroups() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('groups').get();

    final List<Group> groups =
        querySnapshot.docs.map((doc) => Group.fromFirestore(doc)).toList();

    state = groups;
    return groups;
  }

  Future<void> addGroup(Group newGroup, File image) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await FirebaseFirestore.instance
            .collection('groups')
            .add(newGroup.toFirestore());
    String id = documentReference.id;

    String imageUrl = await storageHelper.uploadImageAndGetURL(id, image);
    await updateGroupImageUrl(id, imageUrl);
    newGroup.setId(id);
    newGroup.setImage(imageUrl);

    ActivityService().addNewGroup(newGroup.name);

    state = [...state, newGroup];
  }

  Future<Group> getGroupById(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> response =
        await FirebaseFirestore.instance.collection('groups').doc(id).get();
    return Group.fromFirestore(response);
  }

  Future<void> updateGroupImageUrl(String groupId, String url) async {
    await FirebaseFirestore.instance.collection('groups').doc(groupId).update({
      'image': url,
    });
  }

  Group getGroupByIdFromProvider(String id) {
    return state.firstWhere((element) => element.id == id);
  }

  Future<void> updateGroupTotalCollected(String id, double amount) async {
    Group group = await getGroupById(id);
    await FirebaseFirestore.instance.collection('groups').doc(id).update({
      'totalCollected': (group.totalCollected + amount),
      'updatedAt': DateTime.now()
    });
    _updateTotalCollectionInProvider(id, amount);
  }

  Future<void> updateGroupTotalExpenses(String id, double amount) async {
    Group group = await getGroupById(id);
    await FirebaseFirestore.instance.collection('groups').doc(id).update({
      'totalExpenses': (group.totalExpenses + amount),
      'updatedAt': DateTime.now()
    });
    _updateTotalExpensesInProvider(id, amount);
  }

  void _updateTotalExpensesInProvider(String groupId, double amount) {
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
          totalExpenses: (group.totalExpenses + amount),
        );
      } else {
        return group;
      }
    }).toList();
  }

  void _updateTotalCollectionInProvider(String groupId, double amount) {
    state = state.map((group) {
      if (group.id == groupId) {
        return Group.transactionalUpdate(
          id: group.id,
          name: group.name,
          description: group.description,
          eventDate: group.eventDate,
          createdAt: group.createdAt,
          image: group.image,
          totalCollected: (group.totalCollected + amount),
          totalExpenses: group.totalExpenses,
        );
      } else {
        return group;
      }
    }).toList();
  }

  List<Group> filterListByName(String query) {
    return List<Group>.from(state)
        .where((Group group) =>
            group.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

final groupProvider =
    StateNotifierProvider<GroupNotifier, List<Group>>((ref) => GroupNotifier());
