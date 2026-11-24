import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/drivers/ui/screen/widgets/drivers_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DriverFilterBar extends StatelessWidget {
  final DriverFilterColumn selectedColumn;
  final String filterValue;
  final ValueChanged<DriverFilterColumn> onColumnChanged;
  final ValueChanged<String> onValueChanged;

  const DriverFilterBar({
    super.key,
    required this.selectedColumn,
    required this.filterValue,
    required this.onColumnChanged,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filterActive = selectedColumn.fieldName != null;

    return Row(
      children: [
        const Text('Filter By'),
        horizontalSpace(10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DriverFilterColumn>(
              value: selectedColumn,
              items: DriverFilterColumn.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                  .toList(),
              onChanged: (c) {
                if (c != null) {
                  onColumnChanged(c);
                  onValueChanged('');
                }
              },
            ),
          ),
        ),
        horizontalSpace(10),
        if (filterActive)
          SizedBox(
            width: 200,
            child: TextField(
              autofocus: true,
              keyboardType: selectedColumn.isNumeric
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: selectedColumn.isNumeric
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              onChanged: onValueChanged,
              decoration: InputDecoration(
                hintText: ' Search by ${selectedColumn.label}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
      ],
    );
  }
}
