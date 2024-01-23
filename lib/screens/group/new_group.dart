import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/group/new_group_form.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const NewGroupForm());
  }
}
