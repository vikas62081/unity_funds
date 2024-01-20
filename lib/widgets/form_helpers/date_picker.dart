import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormat = DateFormat.yMMMMd();

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.onEventDateChanged,
  }) : super(key: key);

  final void Function(DateTime eventDate) onEventDateChanged;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final now = DateTime.now();
  DateTime? _selectedDate;

  Future<void> _showDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 3),
    );
    if (pickedDate == null) return;
    setState(() {
      _selectedDate = pickedDate;
    });
    widget.onEventDateChanged(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showDatePicker,
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: _showDatePicker,
              icon: Icon(
                Icons.calendar_month,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _selectedDate == null
                    ? "DD/MM/YYYY"
                    : dateFormat.format(_selectedDate!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
