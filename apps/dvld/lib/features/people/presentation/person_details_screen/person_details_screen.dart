// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/people/presentation/person_details_screen/logic/person_details_cubit/person_details_cubit.dart';
import 'package:dvld/features/people/presentation/shared_widgets/person_information_card/person_information_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PersonDetailsScreen extends StatelessWidget {
  const PersonDetailsScreen({super.key, required this.personId});

  final int personId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Person Details')),
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20),
            BlocBuilder<PersonDetailsCubit, PersonDetailsState>(
              // buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state is PersonDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is PersonDetailsSuccess) {
                  return PersonInformationCard(
                    person: state.peopleEntity,
                    onEdit: state.peopleEntity == null
                        ? null
                        : (personId) async {
                            final result = await context.pushNamed<bool>(
                              DRoutes.addUpdatePeopleScreen,
                              queryParameters: {
                                'personId': personId.toString(),
                              },
                            );
                            if (result == true && context.mounted) {
                              context
                                  .read<PersonDetailsCubit>()
                                  .getInfoPersonDetailsById(personID: personId);
                            }
                          },
                  );
                }
                if (state is PersonDetailsFailure) {
                  return Center(child: Text(state.errorMessage));
                }
                return const Center(child: Text('Something went wrong'));
              },
            ),
            verticalSpace(20),

            Row(
              mainAxisAlignment: .center,
              children: [
                AppButton.icon(
                  label: 'Close',
                  icon: Icon(Icons.close, color: Colors.red, size: 25),
                  onPressed: () => context.pop(),
                ),
                horizontalSpace(20),

                AppButton.icon(
                  label: 'Close && Refresh',
                  icon: Icon(Icons.close, color: Colors.red, size: 25),
                  onPressed: () => context.pop(true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
