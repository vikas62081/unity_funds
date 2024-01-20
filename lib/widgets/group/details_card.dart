import 'package:flutter/material.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class GroupDetailsCard extends StatelessWidget {
  const GroupDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle("Balance Amount"),
        AmountText(
          "₹23424",
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ActionCard(
                icon: Icons.arrow_downward, //straight
                amount: "₹20",
                label: "Income",
                iconColor: Color.fromARGB(255, 34, 157, 100),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ActionCard(
                icon: Icons.arrow_upward, //south_rounded
                amount: "₹200,00,00",
                label: "Expense",
                iconColor: Color.fromARGB(255, 240, 34, 34),
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
