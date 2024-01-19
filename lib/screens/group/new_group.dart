import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/group/new_group_form.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Group"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(child: NewGroupForm()),
    );
  }
}
