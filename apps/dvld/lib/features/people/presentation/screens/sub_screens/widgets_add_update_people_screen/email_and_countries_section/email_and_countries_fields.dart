// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/app_text_field.dart';
import 'package:dvld/features/people/presentation/logic/add_pdate_form/add_update_form_cubit.dart';
import 'package:dvld/features/people/presentation/logic/controllers/add_update_people_form_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailAndCountriesFields extends StatelessWidget {
  const EmailAndCountriesFields({Key? key, required this.controllers})
    : super(key: key);

  final AddUpdatePeopleFormControllers controllers;

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: .alphabetic,
      crossAxisAlignment: .baseline,
      children: [
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return AppTextField(
                label: 'Email',
                controller: controllers.emailController,
                prefixIcon: Icons.email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                maxLength: 100,
                isValid: state.email.isValid,
                onChanged: (value) =>
                    context.read<AddUpdateFormCubit>().onChangeEmail(value),
                validator: (p0) {
                  // if (p0!.isEmpty) return 'required Email';
                  return state.email.error;
                },
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BlocBuilder<AddUpdateFormCubit, AddUpdateFormState>(
            buildWhen: (previous, current) =>
                previous.countryStatus.loadCountryStatus !=
                current.countryStatus.loadCountryStatus,
            builder: (context, state) {
              if (state.countryStatus.loadCountryStatus ==
                  RequestStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.countryStatus.loadCountryStatus ==
                  RequestStatus.success) {
                return DropdownButtonFormField<String>(
                  initialValue: controllers.countryController.text,
                  isExpanded: true,
                  hint: const Text("Country"),
                  items: state.countryStatus.countries!
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.countryName,
                          child: Text(e.countryName),
                        ),
                      )
                      .toList(),
                  onChanged: (value) async {
                    controllers.countryController.text = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                );
              }
              if (state.countryStatus.loadCountryStatus ==
                  RequestStatus.failure) {
                return Center(child: Text(state.countryStatus.errorMessage!));
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
