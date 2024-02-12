import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unity_funds/modals/activity.dart';
import 'package:unity_funds/services/activity.dart';
import 'package:unity_funds/widgets/activities/activity_tile.dart';

class ActivityList extends StatefulWidget {
  const ActivityList({super.key});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  final ActivityService _activityService = ActivityService();

  Stream<QuerySnapshot<Map<String, dynamic>>> _getActivityList() {
    return _activityService.getActivity();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _getActivityList(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.data?.docs == null || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }
          return _buildActivityListView(snapshot.data!);
        }));
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text("No Activity added yet.")],
      ),
    );
  }

  Widget _buildActivityListView(
      QuerySnapshot<Map<String, dynamic>> activities) {
    return ListView.builder(
      itemCount: activities.docs.length,
      itemBuilder: (context, index) {
        Activity activity = Activity.fromFirestore(activities.docs[index]);
        return ActivityTile(activity: activity);
      },
    );
  }
}
