// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SetRemoveImagePicker extends StatelessWidget {
  const SetRemoveImagePicker({super.key});

  static final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        children: [
          BlocSelector<AddUpdateFormCubit, AddUpdateFormState, String?>(
            selector: (state) => state.imagePickerStatus.imagePath,
            builder: (context, imagePath) {
              final hasImage = imagePath != null && imagePath.isNotEmpty;
              return Container(
                width: 150,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: hasImage
                    ? Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                      )
                    : const Icon(Icons.person, size: 50, color: Colors.grey),
              );
            },
          ),
          const SizedBox(height: 15),
          AppButton.custom(
            label: 'Set Image',
            icon: const Icon(Icons.upload_file),
            onPressed: () async {
              await pickAndChangeImage(context);
            },
            size: AppButtonSize.small,
          ),
          const SizedBox(height: 8),
          BlocSelector<AddUpdateFormCubit, AddUpdateFormState, bool>(
            selector: (state) => state.imagePickerStatus.isSelectedPath,

            builder: (context, isSelectedPath) {
              if (!isSelectedPath) return const SizedBox.shrink();

              return AppButton.custom(
                label: 'Remove Image',
                icon: const Icon(Icons.remove),
                size: AppButtonSize.small,
                onPressed: () {
                  context.read<AddUpdateFormCubit>().onChangeImagePicker(
                    imagePath: '',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> pickAndChangeImage(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<AddUpdateFormCubit>().onChangeImagePicker(
        imagePath: image.path,
      );
    }
  }
}
