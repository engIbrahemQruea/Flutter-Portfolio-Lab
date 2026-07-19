// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
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
          BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            builder: (context, state) {
              return Container(
                width: 130,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child:
                    state.imagePickerStatus.imagePath == null ||
                        state.imagePickerStatus.imagePath == ''
                    ? const Icon(Icons.person, size: 50, color: Colors.grey)
                    : Image.file(
                        File(state.imagePickerStatus.imagePath!),
                        fit: BoxFit.cover,
                      ),
              );
            },
          ),
          const SizedBox(height: 15),
          AppButton.custom(
            label: 'Set Image',
            icon: const Icon(Icons.upload_file),
            onPressed: () async {
              final image = await _picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                context.read<AddUpdateFormCubit>().onChangeImagePicker(
                  imagePath: image.path,
                );
              }
            },
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
