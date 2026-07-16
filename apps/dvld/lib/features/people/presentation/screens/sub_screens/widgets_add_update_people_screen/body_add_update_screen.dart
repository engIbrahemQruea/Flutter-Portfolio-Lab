// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/address_field.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/email_and_countries_section/email_and_countries_fields.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/geneder_and_phone_section/geneder_and_phone_fields.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/national_and_date_birth_section/national_and_date_birth_field.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/person_full_name_section.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/person_id_section.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/save_close_button_section/save_close_button.dart';
import 'package:dvld/features/people/presentation/screens/sub_screens/widgets_add_update_people_screen/set_remove_image_picker_section/set_remove_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAddUpdateScreen extends StatefulWidget {
  const BodyAddUpdateScreen({super.key, this.personId});

  final int? personId;

  @override
  State<BodyAddUpdateScreen> createState() => _BodyAddUpdateScreenState();
}

class _BodyAddUpdateScreenState extends State<BodyAddUpdateScreen> {
  late final AddUpdatePeopleFormControllers controllers;

  @override
  void initState() {
    super.initState();
    controllers = AddUpdatePeopleFormControllers();
    if (widget.personId != null) {
      context.read<AddUpdateFormCubit>().initializeWithDataModeUpdate(
        personId: widget.personId!,
        controllers: controllers,
      );
    }
  }

  @override
  void dispose() async {
    super.dispose();
    controllers.disposeProviderFormControllers();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controllers.formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PersonIDSection(controllers: controllers),
            const SizedBox(height: 15),

            PersonFullNameSection(controllers: controllers),
            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      NationalNoAndDateOfBirthField(controllers: controllers),
                      const SizedBox(height: 10),
                      GenderAndPhoneFields(controllers: controllers),
                      const SizedBox(height: 10),
                      EmailAndCountriesFields(controllers: controllers),
                      const SizedBox(height: 10),
                      AddressField(controllers: controllers),
                    ],
                  ),
                ),
                const SizedBox(width: 30),

                SetRemoveImagePicker(),
              ],
            ),
            const SizedBox(height: 30),

            SaveCloseButton(controllers: controllers),
          ],
        ),
      ),
    );
  }
}
