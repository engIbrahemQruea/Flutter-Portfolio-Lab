import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:flutter/material.dart';

class ReplacementTypeSelector extends StatelessWidget {
  final IssueReason selected;
  final ValueChanged<IssueReason> onChanged;

  const ReplacementTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Text(
            'Choose Because of Replacement ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              Expanded(
                child: _typeCard(
                  reason: IssueReason.replacementForDamaged,
                  icon: Icons.broken_image_outlined,
                  label: 'Replacement For Damaged',
                  desc: 'License is damaged or broken',
                ),
              ),
              horizontalSpace(10),
              Expanded(
                child: _typeCard(
                  reason: IssueReason.replacementForLost,
                  icon: Icons.search_off,
                  label: 'Replacement For Lost',
                  desc: ' License is lost or stolen',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _typeCard({
    required IssueReason reason,
    required IconData icon,
    required String label,
    required String desc,
  }) {
    final isSelected = selected == reason;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEEEBFF) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFF6A5AE0) : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => onChanged(reason),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: isSelected ? const Color(0xFF6A5AE0) : Colors.grey,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? const Color(0xFF6A5AE0) : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
