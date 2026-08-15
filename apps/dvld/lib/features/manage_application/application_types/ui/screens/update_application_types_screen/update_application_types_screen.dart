import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_application/application_types/ui/logic/update_application_types_screen_cubit/update_application_types_screen_cubit.dart';
import 'package:dvld/features/manage_application/application_types/ui/widgets/helper/update_app_types_screen_controllers.dart';
import 'package:dvld/features/manage_application/application_types/ui/widgets/index_app_types_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateApplicationTypesScreen extends StatefulWidget {
  const UpdateApplicationTypesScreen({super.key});

  @override
  State<UpdateApplicationTypesScreen> createState() =>
      _UpdateApplicationTypesScreenState();
}

class _UpdateApplicationTypesScreenState
    extends State<UpdateApplicationTypesScreen> {
  late UpdateAppTypesScreenControllers _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = UpdateAppTypesScreenControllers();
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Application Types'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child:
              BlocListener<
                UpdateApplicationTypesScreenCubit,
                UpdateApplicationTypesScreenCubitState
              >(
                listenWhen: (previous, current) =>
                    previous.loadApplicationTypesStatus !=
                    current.loadApplicationTypesStatus,
                listener: (context, state) {
                  if (state.loadApplicationTypesStatus.isLoading) {
                    AppDialogs.showLoading(context: context);
                    return;
                  }

                  if (state.loadApplicationTypesStatus.isSuccess) {
                    AppDialogs.dismiss(context);
                    _controllers.applicationTypeIdController.text = state
                        .applicationTypeId
                        .toString();
                    _controllers.applicationTypeTitleController.text =
                        state.applicationTypeTitle.value;
                    _controllers.applicationTypeFeeController.text = state
                        .applicationTypeFee
                        .value
                        .toString();
                  }

                  if (state.loadApplicationTypesStatus.isFailure) {
                    AppDialogs.dismiss(context);
                    AppDialogs.showFailure(
                      context: context,
                      title: 'Error Loading Application Types',
                      message: state.errorMessage!,
                      buttonText: 'Ok',
                    );
                  }
                },
                child: SingleChildScrollView(
                  child: Form(
                    key: _controllers.formKey,
                    child: Column(
                      spacing: 20,
                      children: [
                        AppTypeIdTextFieldWidget(
                          appTypeIdController:
                              _controllers.applicationTypeIdController,
                        ),
                        AppTypeTitleTextFieldWidget(
                          appTypeTitleController:
                              _controllers.applicationTypeTitleController,
                        ),
                        AppTypeFeeTextFieldWidget(
                          appTypeFeeController:
                              _controllers.applicationTypeFeeController,
                        ),
                        verticalSpace(10),
                        AppTypeSaveCloseButtonWidget(
                          appTypeController: _controllers,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
