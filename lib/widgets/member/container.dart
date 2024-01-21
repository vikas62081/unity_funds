import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/member/new_people_form.dart';

class MemberContainer extends StatelessWidget {
  const MemberContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const NewMemberForm(),
    );
  }
}
