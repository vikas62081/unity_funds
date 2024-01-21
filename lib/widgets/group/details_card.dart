import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/utils/colors.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

String getFormattedNumber(number) {
  return NumberFormat.currency(decimalDigits: 1, symbol: "₹").format(number);
}

class GroupDetailsCard extends ConsumerWidget {
  const GroupDetailsCard({super.key, required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Group group =
        ref.watch(groupProvider).where((Group gp) => gp.id == groupId).first;
    final balance = group.totalCollected! - group.totalExpenses!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle("Balance Amount"),
        AmountText(
          getFormattedNumber(balance),
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ActionCard(
                icon: Icons.arrow_downward, //straight
                amount: getFormattedNumber(group.totalCollected),
                label: "Income",
                iconColor: successColor,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ActionCard(
                icon: Icons.arrow_upward, //south_rounded
                amount: getFormattedNumber(group.totalExpenses),
                label: "Expense",
                iconColor: errorColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AmountText extends StatelessWidget {
  const AmountText(this.amount,
      {super.key,
      required this.fontWeight,
      required this.fontSize,
      required this.color});
  final String amount;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      amount,
      style:
          TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String amount;
  final String label;
  final Color iconColor;

  const ActionCard(
      {super.key,
      required this.icon,
      required this.amount,
      required this.label,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AmountText(amount,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: iconColor),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
