import 'package:dvld/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SetRemoveImagePicker extends StatelessWidget {
  const SetRemoveImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          Container(
            width: 130,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          ),
          const SizedBox(height: 15),
          AppButton.custom(
            label: 'Set Image',
            icon: const Icon(Icons.upload_file),
            onPressed: () {},
            size: AppButtonSize.small,
          ),
          const SizedBox(height: 8),
          AppButton.custom(
            label: 'Delete Image',
            icon: const Icon(Icons.remove),
            size: AppButtonSize.small,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}