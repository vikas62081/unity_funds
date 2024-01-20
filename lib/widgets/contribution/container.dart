import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/contribution/contribution_form.dart';

class ContributionContainer extends StatelessWidget {
  const ContributionContainer({super.key});

  void _showContributionModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: AddContributionForm()));
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton.tonalIcon(
                onPressed: () => _showContributionModal(context),
                icon: Icon(Icons.add),
                label: Text("Add")),
          ],
        )
      ],
    );
  }
}
