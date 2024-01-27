import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unity_funds/modals/group.dart';
import 'package:unity_funds/modals/transaction.dart';
import 'package:unity_funds/modals/user.dart';
import 'package:unity_funds/providers/credit_notifier.dart';
import 'package:unity_funds/providers/group_provider.dart';
import 'package:unity_funds/providers/transaction_provider.dart';
import 'package:unity_funds/providers/user_provider.dart';
import 'package:unity_funds/utils/new_transaction_validator.dart';
import 'package:unity_funds/widgets/utils/utils_widgets.dart';

class AddContributionForm extends ConsumerStatefulWidget {
  const AddContributionForm({super.key, this.group});

  final Group? group;

  @override
  ConsumerState<AddContributionForm> createState() =>
      _AddContributionFormState();
}

class _AddContributionFormState extends ConsumerState<AddContributionForm> {
  final _validator = NewTransactionValidator();
  final _formKey = GlobalKey<FormState>();
  User? user;
  Group? group;
  late double amount;
  late bool isEnableGroupInput = true;
  List<User> users = [];
  List<Group> groups = [];

  void _loadUsers() async {
    List<User> userList = await ref.read(userProvider);
    if (userList.isEmpty) {
      await ref.read(userProvider.notifier).getUsers();
      userList = await ref.read(userProvider);
    }
    setState(() {
      users = userList;
    });
  }

  @override
  void initState() {
    _loadUsers();
    groups = ref.read(groupProvider);
    if (widget.group != null) {
      group = widget.group!;
      isEnableGroupInput = false;
    }
    super.initState();
  }

  void _saveForm(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      if (user == null) {
        showDialog(
            context: context,
            builder: (ctx) => const AlertDialog.adaptive(
                  title: Text("Error"),
                  content: Text("Select a member"),
                ));
        return;
      }
      buildLoadingDialog(context);
      _formKey.currentState!.save();
      await ref.read(creditTransactionPrvoider.notifier).addCreditTransaction(
          Transaction.credit(
              groupId: group!.id,
              groupName: group!.name,
              amount: amount,
              contributorName: user!.name,
              contributorUserId: user!.id));
      await ref
          .read(groupProvider.notifier)
          .updateGroupTotalCollected(widget.group!.id, amount);
      if (context.mounted) {
        showSnackbar(context, "Contribution added successfully.");
        Navigator.of(context).pop(); // removing loader
        Navigator.of(context).pop(); // removing form
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionTitle("Add Contributions"),
        const SizedBox(height: 16),
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSearchableDropdown(
                  context: context,
                  icon: Icons.festival_sharp,
                  hintText: "Select group",
                  enabled: isEnableGroupInput,
                  initialSelection: group,
                  items: groups
                      .map((group) =>
                          DropdownMenuEntry(label: group.name, value: group))
                      .toList()),
              const SizedBox(height: 16),
              buildSearchableDropdown(
                  context: context,
                  icon: Icons.person_outline,
                  hintText: "Select a member",
                  onSelected: (value) => user = value!,
                  items: users
                      .map((user) =>
                          DropdownMenuEntry(label: user.name, value: user))
                      .toList()),
              const SizedBox(height: 16),
              buildTextField(
                  context: context,
                  hintText: "0.00",
                  icon: Icons.currency_rupee_outlined,
                  validator: _validator.validateAmount,
                  onSaved: (value) => amount = double.tryParse(value!)!,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              buildSaveButton(
                  context: context, onPressed: () => _saveForm(context)),
            ],
          ),
        ),
      ]),
    );
  }
}
