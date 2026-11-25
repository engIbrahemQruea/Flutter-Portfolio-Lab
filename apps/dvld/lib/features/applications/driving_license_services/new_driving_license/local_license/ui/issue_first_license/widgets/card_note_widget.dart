import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/logic/issue_first_license_cubit/issue_first_license_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardNoteWidget extends StatelessWidget {
  const CardNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: const Text(
              'Notes',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            // width: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: AppTextField(
                label: 'Notes',
                autoFocus: true,
                hintText: 'Enter Notes here ...',
                maxLines: 3,
                maxLength: 500,
                onChanged: (note) =>
                    context.read<IssueFirstLicenseCubit>().changeNote(note),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
