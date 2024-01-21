import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/member/container.dart';
import 'package:unity_funds/widgets/member/member_list.dart';

class MemberScreen extends StatelessWidget {
  const MemberScreen({super.key});
  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const MemberContainer()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MemberList(onAddMember: () => _onFloatingButtonPress(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFloatingButtonPress(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
