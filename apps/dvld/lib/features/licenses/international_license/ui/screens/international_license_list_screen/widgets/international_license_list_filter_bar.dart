import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/widgets/international_license_list_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InternationalLicenseListFilterBar extends StatelessWidget {
  final InternationalLicenseListFilterColumn column;
  final String textValue;
  final bool? boolValue;
  final ValueChanged<InternationalLicenseListFilterColumn> onColumnChanged;
  final ValueChanged<String> onTextChanged;
  final ValueChanged<bool?> onBoolChanged;

  const InternationalLicenseListFilterBar({
    super.key,
    required this.column,
    required this.textValue,
    required this.boolValue,
    required this.onColumnChanged,
    required this.onTextChanged,
    required this.onBoolChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<InternationalLicenseListFilterColumn>(
              value: column,
              items: InternationalLicenseListFilterColumn.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                  .toList(),
              onChanged: (c) {
                if (c != null) onColumnChanged(c);
              },
            ),
          ),
        ),
        const SizedBox(width: 10),

        switch (column.inputType) {
          FilterInputType.text => Expanded(
            child: TextField(
              keyboardType: column.isNumeric
                  ? TextInputType.number
                  : TextInputType.text,
              inputFormatters: column.isNumeric
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              onChanged: onTextChanged,
              decoration: InputDecoration(
                hintText: ' Search By ${column.label}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          FilterInputType.booleanDropdown => Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<bool?>(
                  value: boolValue,
                  isExpanded: true,
                  hint: const Text('All'),
                  items: const [
                    DropdownMenuItem(value: true, child: Text('Yes — Active')),
                    DropdownMenuItem(value: false, child: Text('No — Active')),
                  ],
                  onChanged: onBoolChanged,
                ),
              ),
            ),
          ),
          FilterInputType.none => const Spacer(),
        },
      ],
    );
  }
}
