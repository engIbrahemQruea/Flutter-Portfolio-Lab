// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/save_close_button_section/save_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SaveCloseButton extends StatelessWidget {
  const SaveCloseButton({super.key, required this.controllers});

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        AppButton.custom(
          label: 'Close',
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () => context.pop(false),
        ),
        const SizedBox(width: 20),

        AppButton.custom(
          label: 'Save',
          icon: const Icon(Icons.save),
          onPressed: () async {
            if (controllers.formKey.currentState!.validate()) {
              controllers.formKey.currentState!.save();

              final cubit = context.read<AddUpdateFormCubit>();

              final finalImagePath = cubit.handlePersonImage(
                controllers.imagePathController.text.trim(),
              );
              debugPrint(finalImagePath);

              if (finalImagePath == null) {
                return;
              }

              await cubit.getInfoCountryByName(
                countryName: controllers.countryController.text.trim(),
              );

              final personEntity = PeopleEntity(
                personId: cubit.state.screenStatusMode == ScreenStatus.update
                    ? int.parse(controllers.personIDController.text.trim())
                    : null,
                firstName: controllers.firstNameController.text.trim(),
                secondName: controllers.secondNameController.text.trim(),
                thirdName: controllers.thirdNameController.text.trim(),
                lastName: controllers.lastNameController.text.trim(),
                nationalNo: controllers.nationalNoController.text.trim(),
                dateOfBirth: controllers.dateOfBirthController.text.trim(),
                gender: controllers.genderController.text.trim() == '0' ? 0 : 1,
                phone: controllers.phoneController.text.trim(),
                email: controllers.emailController.text.trim(),
                nationalityCountryId:
                    cubit.state.countryStatus.selectedCountryID!,
                address: controllers.addressController.text.trim(),
                imagePath: finalImagePath ?? '',
              );
              debugPrint(finalImagePath);
              debugPrint(personEntity.imagePath);
              cubit.state.screenStatusMode == ScreenStatus.add
                  ? await cubit.emitSaveAddPerson(personEntity: personEntity)
                  : await cubit.emitSaveUpdatePerson(
                      personEntity: personEntity,
                    );
            }
          },
        ),
        SaveBlocListener(),
      ],
    );
  }
}
