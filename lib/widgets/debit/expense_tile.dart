import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:unity_funds/modals/transaction.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});

  final Transaction expense;

  void _showFullScreenImage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(title: Text("${expense.description} Receipt")),
        body: InkWell(
          onDoubleTap: () => Navigator.of(context).pop(),
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(expense.bill!),
            //   ),
            // ),
          ),
        ),
      );
    }));
  }

  void _showBillingInformation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Billing receipt",
                style: Theme.of(context).textTheme.labelLarge!,
              ),
              const SizedBox(height: 8),
              if (expense.bill != null)
                // InkWell(
                //   onDoubleTap: () => _showFullScreenImage(context),
                //   child: FadeInImage(
                //     height: 350,
                //     placeholder: MemoryImage(kTransparentImage),
                //     image: AssetImage(expense.bill!),
                //   ),
                // )
                // else
                const Center(
                  child: Text("No billing information uploaded."),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showBillingInformation(context),
      leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: expense.color),
          alignment: Alignment.center,
          width: 54,
          height: 54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                expense.createdAt.day.toString(),
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              Text(
                expense.formattedMonth,
                style: const TextStyle(color: Colors.black38),
              )
            ],
          )),
      title: Text(
        expense.description!,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      subtitle: Text(expense.groupName),
      trailing: Text(
        '₹${NumberFormat().format(expense.amount)}',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
