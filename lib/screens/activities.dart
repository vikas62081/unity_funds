import 'package:flutter/material.dart';
import 'package:unity_funds/screens/expense/new_expense.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  void _onFloatingButtonPress(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(),
          body: const NewExpense(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => null,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Center(
        child: Text("Activity"),
      ),
      // floatingActionButton: buildFloatingActionButton(
      //     onPressed: () => _onFloatingButtonPress(context),
      //     label: "Add expense"),
    );
  }
}
