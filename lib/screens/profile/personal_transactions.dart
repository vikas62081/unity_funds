import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/widgets/credit/credit_tile.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class PersonalTransactionScreen extends ConsumerWidget {
  const PersonalTransactionScreen(
      {super.key, required this.userId, required this.label});

  final String userId;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${label.split(' ')[0]}'s Contributions"),
        ),
        body: FutureBuilder(
            future:
                ref.read(transactionPrvoider.notifier).getTransByUserId(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("You have not contributed yet.")],
                  ),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final expense = snapshot.data![index];
                  return CreditTile(expense: expense, isGroupAsTitle: true);
                },
              );
            }));
  }
}
