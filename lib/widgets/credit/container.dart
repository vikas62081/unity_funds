import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/widgets/credit/credit_list.dart';

class ContributionContainer extends ConsumerWidget {
  const ContributionContainer({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: CreditList(
          groupId: group.id,
          onAddExpense: null,
        ))
      ],
    );
  }
}
