import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/applications/test_types/ui/logic/update_test_types_screen_cubit/update_test_types_screen_cubit.dart';
import 'package:dvld/features/applications/test_types/ui/widgets/index_test_types_widgets.dart';
import 'package:dvld/features/applications/test_types/ui/widgets/update_test_types_screen/helper/update_test_types_screen_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTestTypesScreen extends StatefulWidget {
  const UpdateTestTypesScreen({super.key});

  @override
  State<UpdateTestTypesScreen> createState() => _UpdateTestTypesScreenState();
}

class _UpdateTestTypesScreenState extends State<UpdateTestTypesScreen> {
  late UpdateTestTypesScreenControllers _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = UpdateTestTypesScreenControllers();
  }

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Test Types'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child:
              BlocListener<
                UpdateTestTypesScreenCubit,
                UpdateTestTypesScreenCubitState
              >(
                listenWhen: (previous, current) =>
                    previous.loadTestTypesStatus != current.loadTestTypesStatus,
                listener: (context, state) {
                  if (state.loadTestTypesStatus.isLoading) {
                    AppDialogs.showLoading(context: context);
                    return;
                  }

                  if (state.loadTestTypesStatus.isSuccess) {
                    AppDialogs.dismiss(context);
                    _controllers.testTypeIdController.text = state.testTypeId
                        .toString();
                    _controllers.testTypeTitleController.text =
                        state.testTypeTitle.value;
                    _controllers.testTypeDescriptionController.text =
                        state.testTypeDescription.value;
                    _controllers.testTypeFeeController.text = state
                        .testTypeFee
                        .value
                        .toString();
                  }

                  if (state.loadTestTypesStatus.isFailure) {
                    AppDialogs.dismiss(context);
                    AppDialogs.showFailure(
                      context: context,
                      title: 'Error Loading Application Types',
                      message: state.errorMessage,
                      buttonText: 'Ok',
                    );
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      TestTypeIdTextFieldWidget(
                        appTypeIdController: _controllers.testTypeIdController,
                      ),
                      TestTypeTitleTextFieldWidget(
                        testTypeTitleController:
                            _controllers.testTypeTitleController,
                      ),
                      TestTypeDescriptionTextFieldWidget(
                        testTypeDescriptionController:
                            _controllers.testTypeDescriptionController,
                      ),
                      TestTypeFeeTextFieldWidget(
                        testTypeFeeController:
                            _controllers.testTypeFeeController,
                      ),
                      verticalSpace(10),
                      TestTypeSaveCloseButtonWidget(
                        testTypeController: _controllers,
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
