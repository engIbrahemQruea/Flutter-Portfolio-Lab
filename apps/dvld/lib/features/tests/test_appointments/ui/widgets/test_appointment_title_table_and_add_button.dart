// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/logic/driving_license_application_info_cubit/driving_license_application_info_cubit.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';
import 'package:dvld/features/tests/test_appointments/ui/logic/test_appointments_list/test_appointments_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestAppointmentTitleTableAndAddButton extends StatelessWidget {
  const TestAppointmentTitleTableAndAddButton({
    super.key,
    required this.testType,
  });

  final ScheduleTestType testType;

  @override
  Widget build(BuildContext context) {
    final localDrLiApplicationId = context
        .select<DrivingLicenseApplicationInfoCubit, int?>(
          (cubit) => cubit
              .state
              .localDrLiApplicationDetailsReadEntity
              ?.localApplicationEntity
              .localDrLiAppId,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Test Appointments',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        BlocListener<TestAppointmentsListCubit, TestAppointmentsListCubitState>(
          listenWhen: (previous, current) =>
              previous.canPrescheduleTestStatus !=
              current.canPrescheduleTestStatus,
          listener: (context, state) {
            if (state.canPrescheduleTestStatus.isFailure) {
              AppDialogs.showFailure(
                context: context,
                title: 'Error',
                buttonText: 'OK',
                message:
                    state.errorMessageCanPrescheduleTest ??
                    'An unexpected error occurred',
              );
            } else if (state.canPrescheduleTestStatus.isSuccess) {
              context.pushNamed(
                DRoutes.scheduleTestWidgetScreen,
                extra: testType,
                queryParameters: {
                  'localDrLiApplicationId': (localDrLiApplicationId ?? 0)
                      .toString(),
                },
              );
            }
          },
          child: AppButton.custom(
            label: 'Add',
            icon: const Icon(Icons.add),
            onPressed: localDrLiApplicationId == null
                ? null
                : () {
                    context
                        .read<TestAppointmentsListCubit>()
                        .canPrescheduleTest(
                          testTypeId: testType.value,
                          localDlApplicationId: localDrLiApplicationId,
                        );
                  },
          ),
        ),
      ],
    );
  }
}
