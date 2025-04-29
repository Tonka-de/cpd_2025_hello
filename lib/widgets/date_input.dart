import 'package:flutter/material.dart';

/// A widget that provides an input field for selecting a date.
class DateInput extends StatefulWidget {
  /// Callback function to handle date changes.
  /// It takes a [DateTime] as a parameter and returns void.
  final Function(DateTime) onChange;

  /// The initial date to be displayed in the input field.
  final DateTime? date;

  const DateInput({super.key, required this.onChange, this.date});

  @override
  State<DateInput> createState() => _DateInputState();
}

/// The state class for [DateInput].
class _DateInputState extends State<DateInput> {
  /// Initializes the selected date with the provided date or the current date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != widget.date) {
      widget.onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${(widget.date ?? DateTime.now()).toLocal()}".split(' ')[0],
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.date_range),
          ),
        ],
      ),
    );
  }
}
